#!/bin/sh

lxc exec web -- sudo pkill yes
lxc exec web -- sudo sed -i s/^ocumentRoot/DocumentRoot/ /etc/httpd/conf/httpd.conf
lxc exec web -- sudo systemctl start httpd
lxc exec web -- sudo systemctl enable httpd

lxc exec db -- sudo ip link set eth0 up
lxc exec db -- sudo rm /var/log/mudana-file.img
lxc exec db -- sudo systemctl start mariadb
lxc exec db -- sudo systemctl enable mariadb

sudo systemctl start nginx