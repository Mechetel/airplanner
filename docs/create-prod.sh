export MY_PROJECT_NAME=production-airplanner
export YOUR_ECR_ID=840573575565
export AWS_DEFAULT_REGION=us-east-1
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin 840573575565.dkr.ecr.us-east-1.amazonaws.com

aws ec2 create-security-group --group-name $MY_PROJECT_NAME-server-app --description "Production Air project Server App"
export PRODUCTION_SERVER_APP_SG=sg-04b6f971df393112e

aws ec2 authorize-security-group-ingress \
  --group-id $PRODUCTION_SERVER_APP_SG \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-id $PRODUCTION_SERVER_APP_SG \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

aws s3api create-bucket --bucket $MY_PROJECT_NAME-bucket

ecs-cli configure --region $AWS_DEFAULT_REGION --cluster $MY_PROJECT_NAME-cluster --config-name $MY_PROJECT_NAME-cluster

aws ec2 describe-subnets | jq '.Subnets[] | .SubnetId'
export AWS_SUBNETS=subnet-cad141eb,subnet-21a57c10,subnet-c463f49b,subnet-aab73dcc,subnet-96e5a998,subnet-b96045f4

aws ec2 describe-vpcs
export AWS_VPC=vpc-2a862057

aws ec2 create-key-pair \
  --key-name $MY_PROJECT_NAME-keypair \
  --query 'KeyMaterial' \
  --output text > ~/.ssh/$MY_PROJECT_NAME-keypair.pem

chmod 400 ~/.ssh/$MY_PROJECT_NAME-keypair.pem

ecs-cli up --force \
  --keypair $MY_PROJECT_NAME-keypair \
  --capability-iam \
  --size 1 \
  --instance-type t2.micro \
  --vpc $AWS_VPC \
  --subnets $AWS_SUBNETS \
  --image-id ami-0a6be20ed8ce1f055 \
  --security-group $PRODUCTION_SERVER_APP_SG \
  --cluster-config $MY_PROJECT_NAME-cluster \
  --verbose

export EC2_PUBLIC_DOMAIN=54.173.142.69
ssh -i ~/.ssh/production-airplanner-keypair.pem ec2-user@$EC2_PUBLIC_DOMAIN

aws ecr create-repository --repository-name $MY_PROJECT_NAME/be_with_deps
aws ecr create-repository --repository-name $MY_PROJECT_NAME/nginx

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/production-airplanner/be_with_deps:latest" \
  -f docker/dockerfiles/be_with_deps.Dockerfile .

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/production-airplanner/nginx:latest" \
  -f docker/dockerfiles/nginx.Dockerfile docker/datum/nginx/

docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/production-airplanner/be_with_deps:latest"
docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/production-airplanner/nginx:latest"

ecs-cli compose \
  --file docker/production.yml \
  --project-name $MY_PROJECT_NAME-cluster \
  --ecs-params docker/production-ecs-params.yml \
  --cluster-config $MY_PROJECT_NAME-cluster \
  create

aws ecs create-service \
  --service-name "$MY_PROJECT_NAME-service" \
  --cluster $MY_PROJECT_NAME-cluster \
  --task-definition "production-airplanner-cluster:1" \
  --desired-count 1 \
  --deployment-configuration "maximumPercent=200,minimumHealthyPercent=50"
