#!/bin/sh

sudo systemctl stop nginx

lxc exec web -- sudo systemctl stop httpd
lxc exec web -- sudo systemctl disable httpd
lxc exec web -- sudo yes > /dev/null &
lxc exec web -- sudo sed -i s/^DocumentRoot/ocumentRoot/ /etc/httpd/conf/httpd.conf

lxc exec db -- sudo ip link set eth0 down
lxc exec db -- sudo systemctl stop mariadb
lxc exec db -- sudo systemctl disable mariadb
lxc exec db -- sudo dd if=/dev/random of=/var/log/mudana-file.img bs=1M count=3750
