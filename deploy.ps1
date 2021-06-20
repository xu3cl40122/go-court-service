docker build -t xu3cl40122/gc-service -f .\Dockerfile.prod .
docker push xu3cl40122/gc-service
ssh -i D:\Lee\sideProject\god\gc-service.pem ec2-user@ec2-52-11-194-84.us-west-2.compute.amazonaws.com sudo bash /home/ec2-user/projects/go-court-service/updateDocker.sh

