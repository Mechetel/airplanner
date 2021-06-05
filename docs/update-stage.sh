export MY_PROJECT_NAME=staging-airplanner
export YOUR_ECR_ID=840573575565
export AWS_DEFAULT_REGION=us-east-1
export EC2_PUBLIC_DOMAIN=34.230.26.168
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $YOUR_ECR_ID.dkr.ecr.us-east-1.amazonaws.com

ssh -i ~/.ssh/staging-airplanner-keypair.pem ec2-user@$EC2_PUBLIC_DOMAIN

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/be_with_deps:latest" \
  -f docker/dockerfiles/be_with_deps.Dockerfile .

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/nginx:latest" \
  -f docker/dockerfiles/nginx.Dockerfile docker/datum/nginx/

docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/be_with_deps:latest"
docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/nginx:latest"

ecs-cli compose \
  --file docker/staging.yml \
  --project-name $MY_PROJECT_NAME-cluster \
  --ecs-params docker/staging-ecs-params.yml \
  --cluster-config $MY_PROJECT_NAME-cluster \
  create

aws ecs update-service \
  --service "$MY_PROJECT_NAME-service" \
  --cluster "$MY_PROJECT_NAME-cluster" \
  --task-definition "staging-airplanner-cluster:20" \
  --desired-count 1 \
  --deployment-configuration "maximumPercent=200,minimumHealthyPercent=50"
