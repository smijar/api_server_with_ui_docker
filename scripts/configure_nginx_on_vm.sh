# NOTE-this is NOT for the docker confguration
# This is only for configuring A host VM that has nginx, mongodb, JDK installed

set -x
set -e

#-------
# configure nginx
scp ../../ui/conf/nginx.conf root@10.2.22.81:/etc/nginx/
scp ../../ui/conf/certs/* root@10.2.22.81:/etc/nginx/certs/
scp ../../ui/conf/conf.d/gzip.conf root@10.2.22.81:/etc/nginx/conf.d/
scp ../../ui/conf/conf.d/location_params root@10.2.22.81:/etc/nginx/conf.d/
scp ../appui/conf/conf.d/app.conf.vm root@10.2.22.81:/etc/nginx/conf.d/app.conf
scp ../appui/conf/conf.d/default.conf root@10.2.22.81:/etc/nginx/conf.d/default.conf


ssh root@10.2.22.81 "mkdir -p /etc/nginx/conf.d/"
ssh root@10.2.22.81 "chmod -R 755 /etc/nginx/"
ssh root@10.2.22.81 "chown -R root:root /etc/nginx"


ssh root@10.2.22.81 "mkdir -p /usr/share/nginx/html/app/"
ssh root@10.2.22.81 "chmod -R 755 /usr/share/nginx/html/app/*"
ssh root@10.2.22.81 "chown -R root:root /usr/share/nginx/html/app/*"

# test the config
ssh root@10.2.22.81 "sudo nginx -t"

# stop the firewall
ssh root@10.2.22.81 "systemctl stop firewalld"
ssh root@10.2.22.81 "systemctl disable firewalld"
#ssh root@10.2.22.81 "chkconfig stop firewalld"

# restart nginx after config changes above
ssh root@10.2.22.81 "sudo service nginx restart"
