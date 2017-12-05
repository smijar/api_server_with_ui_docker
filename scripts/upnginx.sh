cd ..
sudo ifconfig lo0 alias 172.20.123.1
docker-compose -f docker-compose-nginx.yml up --remove-orphans
