#!/bin/sh
#
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PUBLIC_HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/public-hostname -H "X-aws-ec2-metadata-token: $TOKEN"`
PRIVATE_ADDRESS=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4 -H "X-aws-ec2-metadata-token: $TOKEN"`

echo "--- your informations ---"
echo ""
echo "your public internet hostname"
echo $PUBLIC_HOSTNAME

echo ""
echo "your website"
echo $PUBLIC_HOSTNAME/myapp/

echo ""
echo "your monitoring dashboard"
echo $PUBLIC_HOSTNAME:9999
echo "username: user1"
echo "password: password"

echo ""
echo "your private address"
echo $PRIVATE_ADDRESS

echo ""