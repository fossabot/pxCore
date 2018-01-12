#!/bin/sh
export DEPLOY_EXTERNAL_PATH=${DEPLOY_EXTERNAL_PATH:-http://96.116.56.119/ciresults/external.tgz}
REMOTE_HOST="$1"
DEST_FILE="$2"
wget -q $DEPLOY_EXTERNAL_PATH -P $2
if [ "$?" -ne 0 ]
then
  echo "******************wget failed in download_external***************"
  exit 1;
fi
