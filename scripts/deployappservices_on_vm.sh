# NOTE - this is ONLY for deploying the code to a VM (not for docker case) that has nginx installed

set -x
set -e

pushd .
cd ../app/
mvn clean package
# tarball appservices
TIMESTAMP=`date "+%Y-%m-%d-%H-%M-%S"`
FILENAME=appservices-${TIMESTAMP}.tar
echo $TIMESTAMP > timestamp.txt
tar cvf $FILENAME target/appapp-1.0-SNAPSHOT.jar
tar rvf $FILENAME conf/app.yml
tar rvf $FILENAME devstart.sh
tar rvf $FILENAME start.sh
tar rvf $FILENAME myapp.service

# client p12 to be able to talk to management server API
tar rvf $FILENAME conf/api.p12

mv $FILENAME ../

# deploy the tarball
cd ..
ssh root@10.2.22.81 "mkdir -p /opt/company/app/app/ && mkdir -p ~/tars/"
scp $FILENAME root@10.2.22.81:~/tars/
ssh root@10.2.22.81 "rm -rf ;cd /opt/company/app/app/ && tar xvf ~/tars/$FILENAME"
ssh root@10.2.22.81 "cp /opt/company/app/app/appapp.service /usr/lib/systemd/system/appapp.service"


# remove from local
rm $FILENAME

ssh root@10.2.22.81 "pkill -f java"

# to run the service
# cd /opt/company/app/app
# ./start.sh
# this runs it in the background

popd
