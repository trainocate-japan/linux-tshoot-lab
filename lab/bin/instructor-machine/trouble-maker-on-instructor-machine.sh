#!/bin/sh
aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --region ap-northeast-1 \
    --targets Key=resource-groups:Name,Values=linux-tshoot-targets \
    --parameters commands=["sudo systemctl stop nginx","lxc exec app -- sudo systemctl stop httpd","lxc exec app -- sudo systemctl disable httpd","lxc exec app -- sudo sed -i s/^DocumentRoot/ocumentRoot/ /etc/httpd/conf/httpd.conf","lxc exec db -- sudo systemctl stop mariadb","lxc exec db -- sudo systemctl disable mariadb"] \
    --output json|jq -r '.Command.CommandId'