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
cd utils
sudo ./install_server.sh
rm -rf /tmp/redis-stable

# INSTALL GIT
sudo apt-get -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev

cd /tmp
wget -O git.zip https://github.com/git/git/archive/master.zip
unzip git.zip
cd git-master
make configure
./configure --prefix=/usr/local
make all doc
sudo make install
sudo ln -s /usr/local/bin/git /usr/bin/git
cd ..
rm -rf git.zip
rm -rf git-master



# CLEAN MEMORY
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'




