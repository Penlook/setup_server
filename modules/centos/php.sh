#!/bin/bash
# PHP
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
yum install -y php55w* --skip-broken
yum install -y mysql55w*

# YAML
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum remove -y libyaml*
yum install -y libyaml-devel
echo "" | pecl install yaml

pecl install redis
echo "no" | pecl install mongo
pecl install igbinary