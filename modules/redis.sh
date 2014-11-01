#!/bin/bash
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum install -y redis

TMP=`pwd`
cd /tmp
wget https://github.com/nicolasff/phpredis/archive/master.zip -O phpredis.zip
unzip ./phpredis.zip
rm -rf phpredis.zip 
cd phpredis-master
phpize
./configure
make && make install
rm -rf ../phpredis-master 
cd $TMP