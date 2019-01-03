#!/bin/bash
echo "Simple fcm sender"
while getopts k:b:m:t: option
do
case "${option}"
in
k) KEY=${OPTARG};;
b) BODY=${OPTARG};;
m) MESSAGE=${OPTARG};;
t) TOPIC=${OPTARG};;
esac
done

echo 'KEY='$KEY
echo 'BODY='$BODY
echo 'MESSAGE='$MESSAGE

API_ENDPOINT='https://fcm.googleapis.com/fcm/send'
SED_ARGS="s/##MESSAGE##/$MESSAGE/g; s/##TOPIC##/$TOPIC/g;"
echo 'SED_ARGS='$SED_ARGS
echo 'API_ENDPOINT='$API_ENDPOINT

echo 'Current path is:'
cd /home/fcm
pwd
cp $BODY ./tmp/body.json
sed -i -e "$SED_ARGS" ./tmp/body.json

curl -X POST --header "Authorization: key=$KEY" --Header "Content-Type: application/json" $API_ENDPOINT -d @./tmp/body.json -#


