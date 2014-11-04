cd /tmp
wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm 
yum localinstall -y mysql-community-release-el6-5.noarch.rpm
yum install -y mysql-community-server
