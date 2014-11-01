#!/bin/bash
TMP=`pwd`

git clone https://github.com/json-c/json-c.git
cd json-c
sh autogen.sh
./configure
make && make install
rm -rf ../json-c

yum install -y re2c

cd /usr/local/src
git clone https://github.com/phalcon/zephir
cd zephir
./install -c
rm -rf /usr/bin/zephir
ln -s /usr/local/bin/zephir /usr/bin/zephir

cd $TMP