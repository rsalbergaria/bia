./build.sh
aws ecs update-service --cluster cluster-1-web-alb --service service-bia --force-new-deployment
