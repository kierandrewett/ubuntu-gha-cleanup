#!/bin/bash

set -e

echo ""
printf "\033[0;31mWARNING! DO NOT EXECUTE THIS SCRIPT ON YOUR ACTUAL MACHINE!\033[0m\n"
printf "\033[0;31mTHIS SCRIPT IS DESIGNED FOR USE ON THE UBUNTU GITHUB ACTIONS RUNNER\033[0m\n"
echo ""

echo "If you know what you doing, purging commences in 5 seconds... >:)"
echo ""

sleep 5

sudo apt-get remove --allow-remove-essential $(cat apt_remove.txt | tr "\n" " ")
sudo apt-get purge --allow-remove-essential $(cat apt_remove.txt | tr "\n" " ")

cat files_remove.txt | while read f
do
   echo "Removing $f..."
   sudo rm -rf $f
done