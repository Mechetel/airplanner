export MY_PROJECT_NAME=production-airplanner
export YOUR_ECR_ID=840573575565
export AWS_DEFAULT_REGION=us-east-1
# export EC2_PUBLIC_DOMAIN=34.230.26.168
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $YOUR_ECR_ID.dkr.ecr.us-east-1.amazonaws.com

aws ec2 create-security-group \
  --group-name $MY_PROJECT_NAME-balancer \
  --description "Airplanner Production Balancer"
export BALANCER_SG=

aws ec2 create-security-group \
  --group-name $MY_PROJECT_NAME-server-app \
  --description "Airplanner Production Server App"
export SERVER_APP_SG=

aws ec2 create-security-group \
  --group-name $MY_PROJECT_NAME-db \
  --description "Airplanner Production DB"
export DB_SG=

aws ec2 create-security-group \
  --group-name $MY_PROJECT_NAME-store \
  --description "Airplanner Production Memory Store"
export STORE_SG=


aws ec2 authorize-security-group-ingress \
  --group-id $BALANCER_SG \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-id $SERVER_APP_SG \
  --protocol tcp \
  --port 8080 \
  --source-group $BALANCER_SG

aws ec2 authorize-security-group-ingress \
  --group-id $DB_SG \
  --protocol tcp \
  --port 5432 \
  --source-group $SERVER_APP_SG

aws ec2 authorize-security-group-ingress \
  --group-id $STORE_SG \
  --protocol tcp \
  --port 6379 \
  --source-group $SERVER_APP_SG

aws s3api create-bucket --bucket $MY_PROJECT_NAME-bucket

export YOUR_DB_USERNAME=
export YOUR_DB_PASSWORD=
aws rds create-db-instance \
  --engine postgres \
  --no-multi-az \
  --vpc-security-group-ids $DB_SG \
  --db-instance-class db.t2.micro \
  --allocated-storage 20 \
  --db-instance-identifier $MY_PROJECT_NAME-ident \
  --db-name $MY_PROJECT_NAME-db \
  --master-username $YOUR_DB_USERNAME \
  --master-user-password $YOUR_DB_PASSWORD

aws rds describe-db-instances

aws elasticache create-cache-cluster \
  --engine redis \
  --security-group-ids $STORE_SG \
  --cache-node-type cache.t2.micro \
  --num-cache-nodes 1 \
  --cache-cluster-id $MY_PROJECT_NAME-id

aws ec2 describe-subnets | jq '.Subnets[] | .SubnetId'
export AWS_SUBNETS=subnet-cad141eb,subnet-21a57c10,subnet-c463f49b,subnet-aab73dcc,subnet-96e5a998,subnet-b96045f4

aws ec2 describe-vpcs
export AWS_VPC=vpc-2a862057

aws elb create-load-balancer \
  --load-balancer-name $MY_PROJECT_NAME-balancer \
  --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=8080" \
  --subnets $AWS_SUBNETS \
  --security-groups $BALANCER_SG

aws elb modify-load-balancer-attributes \
  --load-balancer-name $MY_PROJECT_NAME-balancer \
  --load-balancer-attributes "{\"ConnectionSettings\":{\"IdleTimeout\":5}}"

aws elb describe-load-balancers

ecs-cli configure --region $AWS_DEFAULT_REGION --cluster $MY_PROJECT_NAME-cluster --config-name $MY_PROJECT_NAME-cluster

aws ec2 create-key-pair \
  --key-name $MY_PROJECT_NAME-keypair \
  --query 'KeyMaterial' \
  --output text > ~/.ssh/$MY_PROJECT_NAME-keypair.pem

chmod 400 ~/.ssh/$MY_PROJECT_NAME-keypair.pem

ecs-cli up --force \
  --keypair $MY_PROJECT_NAME-keypair \
  --capability-iam \
  --size 3 \
  --instance-type t2.micro \
  --vpc $AWS_VPC \
  --subnets $AWS_SUBNETS \
  --image-id ami-0a6be20ed8ce1f055 \
  --security-group $SERVER_APP_SG \
  --cluster-config $MY_PROJECT_NAME \
  --verbose
