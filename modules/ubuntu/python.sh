cd /tmp
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
sudo python setup.py install
cd ..
sudo rm -rf setuptools-1.4.2.tar.gz
sudo rm -rf setuptools-1.4.2

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py

# INSTALL PIP
sudo apt-get -y install python-pip
sudo pip install virtualenv --upgrade
sudo pip install redis  --upgrade
sudo pip install nose --upgrade
sudo pip install pyyaml --upgrade
