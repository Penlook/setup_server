#!/bin/bash
cd /tmp

rm -rf json-c
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-json-c.tar" -O json-c.tar
sudo tar -xvf json-c.tar
sudo rm -rf json-c.tar
cd json-c
sudo make install
cd ..

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