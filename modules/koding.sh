#!/bin/sh

# REMOVE ALL COMPONENT
USER=`whoami`
sudo rm -rf /home/root/*
sudo rm -rf /home/$USER/*
sudo apt-get -y --force-yes autoremove python* java* ruby* ruby1.9.1* apache2* apache2-* git vim-* golang-* cpp-* ftp
sudo apt-get -y --force-yes autoremove binutils libcloog-isl4 libfreetype6 libgmp10 libisl10 libmpc3 libmpfr4 os-prober
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'

# INSTALL ESSENTIAL
sudo apt-get update
sudo apt-get -y install tcl8.5 build-essential

# INSTALL REDIS
sudo apt-get -y install redis-server

# INSTALL GIT
sudo apt-get -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
sudo apt-get -y install git-core
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'


# INSTALL NGINX
sudo apt-get -y install nginx

# INSTALL PHALCON

TMP=/tmp
cd $TMP

git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install
cd $TMP

rm -rf cphalcon

cd /usr/local/src
git clone https://github.com/phalcon/phalcon-devtools
cd phalcon-devtools
sudo ./phalcon.sh
ln -s /usr/local/src/phalcon-devtools/phalcon.php /usr/bin/phalcon
cd $TMP

sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'


# INSTALL ZEPHIR
sudo apt-get -y install re2c libpcre3-dev

cd /tmp
git clone https://github.com/json-c/json-c.git
cd json-c
sh autogen.sh
./configure
make && sudo make install
sudo rm -rf ../json-c
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'

cd /usr/local/src
wget https://github.com/cphalcon/zephir/archive/master.zip
unzip master.zip
rm -rf master.zip
cd zephir-master
sudo ./install -c
sudo rm -rf /usr/bin/zephir
sudo ln -s /usr/local/bin/zephir /usr/bin/zephir
cd /tmp
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'
