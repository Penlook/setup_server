#!/bin/bash
cd /tmp

git clone https://github.com/json-c/json-c.git
cd json-c
sh autogen.sh
./configure
make && make install
rm -rf ../json-c

yum install -y re2c

cd /usr/local/src
wget https://github.com/phalcon/zephir/archive/master.zip
unzip master.zip
rm -rf master.zip
cd zephir-master
./install -c
rm -rf /usr/bin/zephir
ln -s /usr/local/bin/zephir /usr/bin/zephir

cd /tmp