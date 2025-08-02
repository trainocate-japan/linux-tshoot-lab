#!/bin/sh

URL_STRING=$(
aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" "Name=tag:user,Values=student" \
    --query "Reservations[].Instances[].PublicDnsName" \
    --output text)

echo "$URL_STRING" | sed 's/\s\+/\n/g' | sed '/^$/d' | sed 's/$/\/myapp\//' > ./urls.csv

echo "urls.csv is ready. run cheker.sh urls.csv"
