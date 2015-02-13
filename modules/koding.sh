#!/bin/bash

# List all installed packages
# dpkg --get-selections | grep -v deinstall
ROOT_SETUP=`dirname "$0"`

# REMOVE ALL COMPONENT
USER=`whoami`
sudo rm -rf /home/root/*
sudo rm -rf /home/$USER/*
sudo apt-get -y --force-yes autoremove java* apache2* apache2-* vim-* golang-* cpp-* ftp
sudo apt-get -y --force-yes autoremove binutils libcloog-isl4 libfreetype6 libgmp10 libisl10 libmpc3 libmpfr4 os-prober
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'

# INSTALL ESSENTIAL
sudo apt-get update
sudo apt-get -y install tcl8.5 build-essential

# INSTALL REDIS
sudo apt-get -y install redis-server

# INSTALL NGINX
sudo apt-get -y install nginx php5-fpm
sudo cp -rf $ROOT_SETUP/../config/nginx.conf /etc/nginx/nginx.conf
sudo cp -rf $ROOT_SETUP/../config/nginx_default.conf /etc/nginx/conf.d/default.conf
sudo sed -i -e "s/USERNAME/$USER/g" /etc/nginx/conf.d/default.conf
sudo useradd --no-create-home nginx
sudo service nginx restart

# CONFIGURE PHP_FPM
#sudo cp -rf $ROOT_SETUP/../config/www.conf /etc/php5/fpm/pool.d/www.conf
#sudo service php5-fpm restart

# INSTALL PHALCON
sudo apt-get install -y php5-dev libpcre3 libpcre3-dev

mkdir -p /usr/local/src
sudo chmod a+w /usr/local/src -R

# INSTALL PHALCON
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-phalcon.so" -O /usr/lib/php5/20121212/phalcon.so
sudo service php5-fpm restart

cd /tmp

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


# INSTALL ZEPHIR
sudo apt-get -y install re2c libpcre3 libpcre3-dev

cd /usr/local/src
git clone https://github.com/phalcon/zephir.git --recursive --depth=1 -b master
cd zephir

rm -rf json-c
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-json-c.tar" -O json-c.tar
sudo tar -xvf json-c.tar
sudo rm -rf json-c.tar
cd json-c
sudo make install
cd ..

./install -c
sudo rm -rf /usr/bin/zephir
sudo ln -s /usr/local/bin/zephir /usr/bin/zephir
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'

# INSTALL GOLANG
TMP=/usr/local/src
cd $TMP
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-go.tar" -O go.tar
sudo tar -xvf go.tar
sudo rm -rf go.tar
GOSCRIPT="/etc/profile.d/golang.sh"
sudo rm -rf $GOSCRIPT
sudo touch $GOSCRIPT
sudo chmod a+w+x $GOSCRIPT
echo "export PATH=\"\$PATH:/usr/local/src/go/bin\"" >> $GOSCRIPT
echo "export GOPATH=\"$HOME\"" >> $GOSCRIPT
source $GOSCRIPT
