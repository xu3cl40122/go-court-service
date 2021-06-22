#!/bin/bash
echo $(pwd)
cd /home/ec2-user/projects/go-court-service/
# 取得新的 image
docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml up -d --remove-orphans
docker image prune -f