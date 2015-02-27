# MIGRATE TO PYTHON 2.7
sudo yum install -y xz-libs openssl-devel zlib-devel bzip2-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel

cd /usr/local/src
sudo wget https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/python27.tar
tar -xvf python27.tar
cd Python-2.7.6
sudo make altinstall
cd ..
rm -rf python27.tar

PYSCRIPT="/etc/profile.d/python.sh"
sudo rm -rf $PYSCRIPT
sudo touch $PYSCRIPT && sudo chmod a+w+x $PYSCRIPT
echo "export PATH=\"\$PATH:/usr/local/bin\"" >> $PYSCRIPT
. $PYSCRIPT

# Setup pip
cd /tmp
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
sudo python2.7 setup.py install
cd ..
rm -rf setuptools-1.4.2.tar.gz
rm -rf setuptools-1.4.2

wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python2.7 get-pip.py
pip install virtualenv --upgrade
pip install redis  --upgrade
pip install nose --upgrade
pip install pyyaml --upgrade
rm -rf get-pip.py
