#!/bin/bash
TMP=/usr/local/src
cd $TMP
sudo wget "https://s3-ap-southeast-1.amazonaws.com/binary-installed-package/ubuntu-go.tar" -O go.tar
sudo tar -xvf go.tar
sudo rm -rf go.tar
GOSCRIPT="/etc/profile.d/golang.sh"
sudo rm -rf $GOSCRIPT
sudo touch $GOSCRIPT
sudo chmod a+w+x $GOSCRIPT
echo "export PATH=\"\$PATH:/usr/local/src/go/bin\"" >> $GOSCRIPT
echo "export GOPATH=\"$HOME\"" >> $GOSCRIPT
. $GOSCRIPT