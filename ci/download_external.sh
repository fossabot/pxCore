#!/bin/sh
export DEPLOY_EXTERNAL_PATH=${DEPLOY_EXTERNAL_PATH:-http://96.116.56.119/externals/}
REMOTE_HOST="$1"
DEST_FILE="$2"
LATEST_FILE=`curl -s $DEPLOY_EXTERNAL_PATH --list-only |sort -t\> -k8 | sed -n 's%.*href="\([^.]*\.tgz\)".*%\n\1%; ta; b; :a; s%.*\n%%; p' | tail -1`
if [ -z "$LATEST_FILE" ]
then
  echo "****************** No Valid external present***************"
  exit 1;  
else  
  echo "********* File to be downloaded: $LATEST_FILE********"
  echo "******curl -s -o "$DEST_FILE/$LATEST_FILE" http://96.116.56.119/externals/$LATEST_FILE*****"
  curl -s -o "$DEST_FILE/$LATEST_FILE" "http://96.116.56.119/externals/$LATEST_FILE"
  #wget -q $DEPLOY_EXTERNAL_PATH -P $2
  if [ "$?" -ne 0 ]
  then
    echo "******************curl command failed with error ***************"
    exit 1;
  fi
fi
