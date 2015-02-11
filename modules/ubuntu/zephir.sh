#!/bin/bash
sudo apt-get install git gcc make re2c php5 php5-json php5-dev libpcre3-dev

cd /tmp

git clone https://github.com/json-c/json-c.git
cd json-c
sh autogen.sh
./configure
make && make install
rm -rf ../json-c

cd /usr/local/src
wget https://github.com/cphalcon/zephir/archive/master.zip
unzip master.zip
rm -rf master.zip
cd zephir-master
./install -c
rm -rf /usr/bin/zephir
ln -s /usr/local/bin/zephir /usr/bin/zephir

cd /tmp