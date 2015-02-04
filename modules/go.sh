#!/bin/bash
TMP=/usr/local/src
sudo mkdir -p $TMP
cd $TMP
wget https://storage.googleapis.com/golang/go1.4.1.src.tar.gz
tar -xvf go1.4.1.src.tar.gz
rm -rf go1.4.1.src.tar.gz
cd go/src
sudo ./all.bash
GOSCRIPT="/etc/profile.d/golang.sh"
sudo rm -rf $GOSCRIPT
sudo touch $GOSCRIPT && sudo chmod a+w+x $GOSCRIPT
echo "export PATH=\"\$PATH:/usr/local/src/go/bin\"" >> $GOSCRIPT
echo -e "export GOPATH=\"$HOME\"" >> $GOSCRIPT
source $GOSCRIPT
