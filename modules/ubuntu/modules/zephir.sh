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

./install -c
sudo rm -rf /usr/bin/zephir
sudo ln -s /usr/local/bin/zephir /usr/bin/zephir
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'