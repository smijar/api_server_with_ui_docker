# This is mainly to add an IP alias for the docker host so that the docker container
# can address services on the host machine using extra_hosts parameter in docker-compose.yml


# provide an alias to the host local loopback
sudo ifconfig lo0 alias 172.20.123.1

# check alias
ifconfig|more

# ping alias from within docker
docker run -it --rm busybox ping 172.20.123.1

# check that the host services are accessible from the aliased IP
telnet 172.20.123.1
telnet 172.20.123.1 443

# or with hostname mapping
or with hostname mapping for app config convenience

docker run -it --rm --add-host=docker.local:172.16.123.1 busybox ping docker.local
