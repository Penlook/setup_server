# INSTALL NGINX
ROOT_SETUP=`dirname "$0"`

# REMOVE ALL COMPONENT
USER=`whoami`

sudo apt-get -y install nginx php5-fpm php5-redis php5-mysql php5-mongo
sudo cp -rf $ROOT_SETUP/../../config/nginx.conf /etc/nginx/nginx.conf
sudo cp -rf $ROOT_SETUP/../../config/nginx_default.conf /etc/nginx/conf.d/default.conf
sudo sed -i -e "s/USERNAME/$USER/g" /etc/nginx/conf.d/default.conf
sudo useradd --no-create-home nginx
sudo service nginx restart

# CONFIGURE PHP_FPM
sudo cp -rf $ROOT_SETUP/../../config/www.conf /etc/php5/fpm/pool.d/www.conf
sudo service php5-fpm restart