#!/bin/bash
rpm --import https://fedoraproject.org/static/0608B895.txt
rpm -Uvh http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum install nodejs npm -y --enablerepo=epel
curl http://npmjs.org/install.sh | sh

npm install -g coffee-script
npm install -g less
npm install -g less-plugin-clean-css
npm install -g mysql
npm install -g mongodb
npm install -g redis
npm install -g memcached
npm install -g socketstream



