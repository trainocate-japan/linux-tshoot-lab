#!/bin/sh
aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --region ap-northeast-1 \
    --targets Key=resource-groups:Name,Values=linux-tshoot-targets \
    --parameters commands=["lxc exec app -- sudo pkill yes","lxc exec app -- sudo sed -i s/^ocumentRoot/DocumentRoot/ /etc/httpd/conf/httpd.conf","lxc exec app -- sudo systemctl start httpd","lxc exec app -- sudo systemctl enable httpd","lxc exec db -- sudo ip link set eth0 up","lxc exec db -- sudo rm /var/log/mudana-file.img","lxc exec db -- sudo systemctl start mariadb","lxc exec db -- sudosystemctl enable mariadb","sudo systemctl start nginx"]