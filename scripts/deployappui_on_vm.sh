# NOTE - this is ONLY for deploying the code to a VM (not for docker case) that has nginx installed

set -x
set -e

pushd .
cd ../appui/
# tarball ui
TIMESTAMP=`date "+%Y-%m-%d-%H-%M-%S"`
FILENAME=appui-${TIMESTAMP}.tar
echo $TIMESTAMP > timestamp.txt
tar cvf $FILENAME --exclude='*.psd' *
mv $FILENAME ../

# deploy the tarball
cd ..
ssh root@10.2.22.81 "mkdir -p /usr/share/nginx/html/myapp/ && mkdir -p ~/tars/"
scp $FILENAME root@10.2.22.81:~/tars/
ssh root@10.2.22.81 "rm -rf ;cd /usr/share/nginx/html/myapp/ && tar xvf ~/tars/$FILENAME && chmod -R 755 *"
ssh root@10.2.22.81 "service nginx reload"

# remove from local
rm $FILENAME

popd
