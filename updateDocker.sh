cd /home/ec2-user/projects/go-court-service/
docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml up -d --remove-orphans
docker image prune -f