#!/bin/bash

set -e

echo ""
printf "\033[0;31mWARNING! DO NOT EXECUTE THIS SCRIPT ON YOUR ACTUAL MACHINE!\033[0m\n"
printf "\033[0;31mTHIS SCRIPT IS DESIGNED FOR USE ON THE UBUNTU GITHUB ACTIONS RUNNER\033[0m\n"
echo ""

echo "If you know what you doing, purging commences in 5 seconds... >:)"
echo ""

sleep 5

sudo apt-get autoremove
sudo apt clean all
sudo docker system prune -a
sudo docker image prune
sudo docker rmi $(docker images -a -q)

sudo dpkg --configure -a

DEBIAN_FRONTEND=noninteractive \
  sudo apt-get --assume-yes install aptitude ubuntu-minimal

DEBIAN_FRONTEND=noninteractive \
  sudo aptitude --assume-yes markauto \
    '~i!?name(ubuntu-minimal~|linux-generic~|systemd~|openssh-server)'

DEBIAN_FRONTEND=noninteractive \
  sudo aptitude --assume-yes purge '~c'

sudo apt-get remove firefox google-chrome-stable snapd -y  

cat files_remove.txt | while read f
do
   echo "Removing $f..."
   sudo rm -rf $f
done

sudo rm -rf /var/log/*gz
sudo rm -rf /tmp