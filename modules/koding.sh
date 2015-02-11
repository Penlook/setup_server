#!/bin/sh

# REMOVE ALL COMPONENT
USER=`whoami`
sudo rm -rf /home/root/*
sudo rm -rf /home/$USER/*
sudo apt-get -y --force-yes autoremove python* php* java* ruby* ruby1.9.1* apache2* apache2-* git vim-* golang-* cpp-* ftp
sudo apt-get autoremove binutils libcloog-isl4 libfreetype6 libgmp10 libisl10 libmpc3 libmpfr4 os-prober

# INSTALL ESSENTIAL
sudo apt-get update
sudo apt-get install tcl8.5 build-essential -y

# INSTALL REDIS
cd /tmp
wget http://download.redis.io/releases/redis-stable.tar.gz
tar -xvf redis-stable.tar.gz
cd redis-stable
make && sudo make install
cd ..
rm -rf redis-stable

# INSTALL PHP


# CLEAN MEMORY
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'




