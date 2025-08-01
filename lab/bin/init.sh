#!/bin/sh
lxc exec db -- sudo dd if=/dev/random of=/var/log/mudana-file.img bs=1M count=3750 &
lxc exec db -- sudo ip link set eth0 down
