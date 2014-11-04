#!/bin/bash
# PHP
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
yum install -y php55w* --skip-broken

# YAML
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum install -y libyaml-devel



echo "no" | pecl install mongo
pecl install redis
echo "yes" | pecl install mongo  
pecl install igbinary