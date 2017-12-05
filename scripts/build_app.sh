set -x
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

pushd $DIR/../apiserver

FILENAME=appservices.tar
tar cvf ../$FILENAME target/app-1.0-SNAPSHOT.jar \
        conf/some_file.csv \
        conf/app.yml \
        devstart.sh \
        start.sh \
        myapp.service

