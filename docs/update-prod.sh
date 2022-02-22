export MY_PROJECT_NAME=production-airplanner
export YOUR_ECR_ID=840573575565
export AWS_DEFAULT_REGION=us-east-1
export EC2_PUBLIC_DOMAIN=54.173.142.69
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $YOUR_ECR_ID.dkr.ecr.us-east-1.amazonaws.com

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

aws ecs update-service \
  --service "$MY_PROJECT_NAME-service" \
  --cluster "$MY_PROJECT_NAME-cluster" \
  --task-definition "production-airplanner-cluster:4" \
  --desired-count 1 \
  --deployment-configuration "maximumPercent=200,minimumHealthyPercent=50"



ssh -i ~/.ssh/production-airplanner-keypair.pem ec2-user@$EC2_PUBLIC_DOMAIN
(docker stop $(docker ps -a -q) || true) && (docker rm $(docker ps -a -q) || true)
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}"
