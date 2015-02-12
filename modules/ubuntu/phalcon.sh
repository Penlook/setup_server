#!/bin/bash
# INSTALL PHALCON
sudo apt-get install -y php5-dev libpcre3 libpcre3-dev

mkdir -p /usr/local/src
sudo chmod a+w /usr/local/src -R

cd /tmp
git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install
PHALCON_INI=/etc/php5/cli/conf.d/90-phalcon.ini
sudo touch $PHALCON_INI
sudo chmod a+w $PHALCON_INI
echo "extension=phalcon.so;" > $PHALCON_INI

sudo service php5-fpm restart

# INSTALL PHALCON TOOLS
cd /usr/local/src
git clone https://github.com/phalcon/phalcon-devtools
cd phalcon-devtools
sudo ./phalcon.sh
sudo rm -rf /usr/bin/phalcon
sudo ln -s /usr/local/src/phalcon-devtools/phalcon.php /usr/bin/phalcon

sudo rm -rf /tmp/*
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'
