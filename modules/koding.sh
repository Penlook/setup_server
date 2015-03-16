#!/bin/bash

# Penlook Project
#
# Copyright (c) 2015 Penlook Development Team
#
# --------------------------------------------------------------------
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public
# License along with this program.
# If not, see <http://www.gnu.org/licenses/>.
#
# --------------------------------------------------------------------
#
# Authors:
#     Loi Nguyen       <loint@penlook.com>

# List all installed packages
# dpkg --get-selections | grep -v deinstall
ROOT_SETUP=`dirname "$0"`
USER=`whoami`

# Replace /etc/ssh/sshd_config with sshd_config
sudo cp -rf $ROOT_SETUP/../config/sshd_config /etc/ssh/
sudo service ssh restart
echo -e "root\nroot" | (sudo passwd --quiet $USER)

# REMOVE ALL COMPONENT
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
sudo service redis-server restart

# INSTALL NGINX
sudo apt-get -y install nginx php5-fpm php5-redis php5-mysql php5-mongo
sudo cp -rf $ROOT_SETUP/../config/nginx.conf /etc/nginx/nginx.conf
sudo cp -rf $ROOT_SETUP/../config/nginx_default.conf /etc/nginx/conf.d/default.conf
sudo sed -i -e "s/USERNAME/$USER/g" /etc/nginx/conf.d/default.conf
sudo useradd --no-create-home nginx
sudo service nginx restart

# CONFIGURE PHP_FPM
sudo cp -rf $ROOT_SETUP/../config/www.conf /etc/php5/fpm/pool.d/www.conf
sudo service php5-fpm restart

# INSTALL PHALCON
sudo apt-get install -y php5-dev libpcre3 libpcre3-dev

mkdir -p /usr/local/src
sudo chmod a+w /usr/local/src -R

# INSTALL PHALCON
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-phalcon.so" -O /usr/lib/php5/20121212/phalcon.so
sudo service php5-fpm restart

cd /tmp

PHALCON_INI_CLI=/etc/php5/cli/conf.d/90-phalcon.ini
PHALCON_INI_FPM=/etc/php5/fpm/conf.d/90-phalcon.ini

sudo touch $PHALCON_INI_CLI
sudo chmod a+w $PHALCON_INI_CLI

sudo touch $PHALCON_INI_FPM
sudo chmod a+w $PHALCON_INI_FPM

echo "extension=phalcon.so;" > $PHALCON_INI_CLI
echo "extension=phalcon.so;" > $PHALCON_INI_FPM

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
sudo git clone https://github.com/phalcon/zephir.git --recursive --depth=1 -b master
cd zephir

rm -rf json-c
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-json-c.tar" -O json-c.tar
sudo tar -xvf json-c.tar
sudo rm -rf json-c.tar
cd json-c
sudo make install
cd ..

sudo ./install -c
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
. $GOSCRIPT

# INSTALL PIP
sudo apt-get -y install python-pip
sudo pip install virtualenv --upgrade
sudo pip install redis  --upgrade
sudo pip install nose --upgrade
sudo pip install pyyaml --upgrade

