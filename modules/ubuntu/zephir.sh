#!/bin/bash
sudo apt-get install git gcc make re2c php5 php5-json php5-dev libpcre3-dev

# INSTALL ZEPHIR
sudo apt-get -y install re2c libpcre3-dev

cd /usr/local/src
git clone https://github.com/phalcon/zephir.git --recursive --depth=1 -b master
cd zephir

cd json-c
sh autogen.sh
./configure
make && sudo make install
cd ..

./install -c
sudo rm -rf /usr/bin/zephir
sudo ln -s /usr/local/bin/zephir /usr/bin/zephir
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'