#GCC 4.8
cd /etc/yum.repos.d
wget http://people.centos.org/tru/devtools-2/devtools-2.repo
yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-gfortran devtoolset-2-gcc-c++
scl enable devtoolset-2 bash
cd /tmp