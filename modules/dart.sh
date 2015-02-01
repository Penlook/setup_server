#!/bin/bash
TMP=/usr/local/src
sudo mkdir -p $TMP
cd $TMP
wget https://storage.googleapis.com/dart-archive/channels/stable/release/42828/sdk/dartsdk-linux-ia32-release.zip
unzip dartsdk-linux-ia32-release.zip
rm -rf dartsdk-linux-ia32-release.zip

DARTSCRIPT="/etc/profile.d/dartlang.sh"
sudo rm -rf $DARTSCRIPT
sudo touch $DARTSCRIPT && sudo chmod a+w+x $DARTSCRIPT
echo "export PATH=\"\$PATH:/usr/local/src/dart-sdk/bin\"" >> $DARTSCRIPT
source $DARTSCRIPT