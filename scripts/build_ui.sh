set -x
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

pushd $DIR/../ui
# tarball ui
FILENAME=ui.tar
tar -cvf ../$FILENAME --exclude='*.psd' *

