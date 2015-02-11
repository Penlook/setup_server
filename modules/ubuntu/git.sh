sudo yum remove -y git
sudo yum install zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto openssl-devel -y
cd /tmp
wget -O git.zip https://github.com/git/git/archive/master.zip
unzip git.zip
cd git-master
make configure
./configure --prefix=/usr/local
make all doc
sudo make install install-doc install-html
sudo ln -s /usr/local/bin/git /usr/bin/git
cd ..
rm -rf git.zip
rm -rf git-master
