docker rm -f $(docker ps -qa);
docker rmi -f $(docker images -qa);
docker volume rm $(docker volume ls -q);
