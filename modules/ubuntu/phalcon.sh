# INSTALL PHALCON
sudo apt-get install -y php5-dev libpcre3 libpcre3-dev

sudo mkdir -p /usr/local/src
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
