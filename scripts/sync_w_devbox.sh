ssh root@10.2.22.81 "docker stop app_myapp-nginx_1 && docker stop app_myapp_1 && docker stop app_mongodb_1"

ssh root@10.2.22.81 "rm -rf ~/app && rm -rf ~/ui && mkdir -p ~/app/ && mkdir -p ~/ui/"
#scp -r ../* root@10.2.22.81:~/app/
pushd .
cd ..
rsync -avz --exclude docker-volumes ../ui/conf/* root@10.2.22.81:/root/ui/conf
rsync -avz --exclude docker-volumes ./* root@10.2.22.81:/root/app/

popd
