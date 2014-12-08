#!/bin/bash
cd /tmp

git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
./install
cd $TMP
rm -rf cphalcon

cd /usr/local/src
git clone https://github.com/phalcon/phalcon-devtools
cd phalcon-devtools
./phalcon.sh
ln -s /usr/local/src/phalcon-devtools/phalcon.php /usr/bin/phalcon

cd /tmp