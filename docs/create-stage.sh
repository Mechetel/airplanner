nix-env -iA nixpkgs.amazon-ecs-cli
nix-env -iA nixpkgs.awscli2

PATH=/nix/store/0i7bg466cfsxpnxljqrvqyzip36hf5j2-awscli2-2.1.35/bin/:$PATH

export $(grep -v '^#' docker/secret-envs/aws.env | xargs)

export MY_PROJECT_NAME=staging-airplanner

aws ec2 create-security-group --group-name $MY_PROJECT_NAME-server-app --description "Staging Air project Server App"

export STAGING_SERVER_APP_SG=sg-0530ba5000274ac39

aws ec2 authorize-security-group-ingress \
  --group-id $STAGING_SERVER_APP_SG \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
  --group-id $STAGING_SERVER_APP_SG \
  --protocol tcp \
  --port 22 \
  --cidr 0.0.0.0/0

aws s3api create-bucket --bucket $MY_PROJECT_NAME-bucket

# {
#     "Location": "/staging-airplanner-bucket"
# }

export AWS_DEFAULT_REGION=us-east-1

ecs-cli configure --region $AWS_DEFAULT_REGION --cluster $MY_PROJECT_NAME-cluster --config-name $MY_PROJECT_NAME-cluster
# INFO[0000] Saved ECS CLI cluster configuration staging-airplanner-cluster.

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
  --security-group $STAGING_SERVER_APP_SG \
  --cluster-config $MY_PROJECT_NAME-cluster \
  --verbose

export EC2_PUBLIC_DOMAIN=34.230.26.168
ssh -i ~/.ssh/staging-airplanner-keypair.pem ec2-user@$EC2_PUBLIC_DOMAIN

aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin 840573575565.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository --repository-name $MY_PROJECT_NAME/be_with_deps
aws ecr create-repository --repository-name $MY_PROJECT_NAME/nginx

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/be_with_deps:latest" \
  -f docker/dockerfiles/be_with_deps.Dockerfile .

docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/be_with_deps:latest"

docker build \
  --tag "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/nginx:latest" \
  -f docker/dockerfiles/nginx.Dockerfile docker/datum/nginx/

docker push "840573575565.dkr.ecr.us-east-1.amazonaws.com/staging-airplanner/nginx:latest"

export YOUR_ECR_ID=840573575565

# aws logs create-log-group --log-group-name $MY_PROJECT_NAME-cluster

ecs-cli compose \
  --file docker/staging.yml \
  --project-name $MY_PROJECT_NAME-cluster \
  --ecs-params docker/staging-ecs-params.yml \
  --cluster-config $MY_PROJECT_NAME-cluster \
  create

# INFO[0001] Using ECS task definition                     TaskDefinition="staging-airplanner-cluster:1"

aws ecs create-service \
  --service-name "$MY_PROJECT_NAME-service" \
  --cluster $MY_PROJECT_NAME-cluster \
  --task-definition "staging-airplanner-cluster:2" \
  --desired-count 1 \
  --deployment-configuration "maximumPercent=200,minimumHealthyPercent=50"

aws ecs update-service \
  --service "$MY_PROJECT_NAME-service" \
  --cluster $MY_PROJECT_NAME-cluster \
  --task-definition "staging-airplanner-cluster:2" \
  --desired-count 1 \
  --deployment-configuration "maximumPercent=200,minimumHealthyPercent=50"

# {
#     "service": {
#         "serviceArn": "arn:aws:ecs:us-east-1:840573575565:service/staging-airplanner-cluster/staging-airplanner-service",
#         "serviceName": "staging-airplanner-service",
#         "clusterArn": "arn:aws:ecs:us-east-1:840573575565:cluster/staging-airplanner-cluster",
#         "loadBalancers": [],
#         "serviceRegistries": [],
#         "status": "ACTIVE",
#         "desiredCount": 1,
#         "runningCount": 0,
#         "pendingCount": 0,
#         "launchType": "EC2",
#         "taskDefinition": "arn:aws:ecs:us-east-1:840573575565:task-definition/staging-airplanner-cluster:1",
#         "deploymentConfiguration": {
#             "deploymentCircuitBreaker": {
#                 "enable": false,
#                 "rollback": false
#             },
#             "maximumPercent": 200,
#             "minimumHealthyPercent": 50
#         },
#         "deployments": [
#             {
#                 "id": "ecs-svc/5259982976645598311",
#                 "status": "PRIMARY",
#                 "taskDefinition": "arn:aws:ecs:us-east-1:840573575565:task-definition/staging-airplanner-cluster:1",
#                 "desiredCount": 1,
#                 "pendingCount": 0,
#                 "runningCount": 0,
#                 "failedTasks": 0,
#                 "createdAt": "2021-06-01T14:52:41.173000+03:00",
#                 "updatedAt": "2021-06-01T14:52:41.173000+03:00",
#                 "launchType": "EC2",
#                 "rolloutState": "IN_PROGRESS",
#                 "rolloutStateReason": "ECS deployment ecs-svc/5259982976645598311 in progress."
#             }
#         ],
#         "events": [],
#         "createdAt": "2021-06-01T14:52:41.173000+03:00",
#         "placementConstraints": [],
#         "placementStrategy": [],
#         "schedulingStrategy": "REPLICA",
#         "createdBy": "arn:aws:iam::840573575565:root",
#         "enableECSManagedTags": false,
#         "propagateTags": "NONE",
#         "enableExecuteCommand": false
#     }
# }

# export EC2_PUBLIC_DOMAIN=3.84.255.26

ssh -i ~/.ssh/$MY_PROJECT_NAME-keypair.pem ubuntu@ec2-3-84-255-26.compute-1.amazonaws.com
ssh -i ~/.ssh/$MY_PROJECT_NAME-keypair.pem ubuntu@3.84.255.26

curl http://ec2-3-84-255-26.compute-1.amazonaws.com/latest/meta-data/public-hostname
