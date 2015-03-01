# INSTALL PHALCON
sudo apt-get install -y php5-dev libpcre3 libpcre3-dev

sudo mkdir -p /usr/local/src
sudo chmod a+w /usr/local/src -R

# INSTALL PHALCON
cd /tmp

git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install
sudo service php5-fpm restart

cd /tmp

PHALCON_PDO_CLI=/etc/php5/cli/conf.d/20-pdo-mysql.ini
PHALCON_PDO_FPM=/etc/php5/fpm/conf.d/20-pdo-mysql.ini

PHALCON_JSON_CLI=/etc/php5/cli/conf.d/10-json.ini
PHALCON_JSON_FPM=/etc/php5/fpm/conf.d/10-json.ini

PHALCON_INI_CLI=/etc/php5/cli/conf.d/90-phalcon.ini
PHALCON_INI_FPM=/etc/php5/fpm/conf.d/90-phalcon.ini

sudo touch $PHALCON_INI_CLI
sudo chmod a+w $PHALCON_INI_CLI

sudo touch $PHALCON_JSON_FPM
sudo chmod a+w $PHALCON_JSON_FPM

sudo touch $PHALCON_PDO_FPM
sudo chmod a+w $PHALCON_PDO_FPM

echo "extension=phalcon.so;" > $PHALCON_INI_CLI
echo "extension=phalcon.so;" > $PHALCON_INI_FPM

echo "extension=pdo.so;" > $PHALCON_PDO_CLI
echo "extension=pdo.so;" > $PHALCON_PDO_FPM

echo "extension=json.so;" > $PHALCON_JSON_CLI
echo "extension=json.so;" > $PHALCON_JSON_FPM

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
