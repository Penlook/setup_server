#!/bin/bash
TMP=/tmp
cd $TMP

sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-phalcon.so" -O /usr/lib64/php/modules/phalcon.so

cd /usr/local/src
git clone https://github.com/phalcon/phalcon-devtools
cd phalcon-devtools
./phalcon.sh
ln -s /usr/local/src/phalcon-devtools/phalcon.php /usr/bin/phalcon

cd $TMP