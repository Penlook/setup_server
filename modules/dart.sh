#!/bin/bash
# TMP=/usr/local/src
# sudo mkdir -p $TMP
# cd $TMP
# wget https://storage.googleapis.com/dart-archive/channels/stable/release/42828/sdk/dartsdk-linux-ia32-release.zip
# unzip dartsdk-linux-ia32-release.zip
# rm -rf dartsdk-linux-ia32-release.zip
# sudo chmod 755 dart-sdk
# sudo ./all.bash
# DARTSCRIPT="/etc/profile.d/dartlang.sh"
# sudo rm -rf $DARTSCRIPT
# sudo touch $DARTSCRIPT && sudo chmod a+w+x $DARTSCRIPT
# echo "export PATH=\"\$PATH:/usr/local/src/dart-sdk/bin\"" >> $DARTSCRIPT
# source $DARTSCRIPT

TMP=/usr/local/src
sudo mkdir -p $TMP
cd $TMP
sudo yum -y install git subversion make gcc-c++ java-1.6.0-openjdk-devel
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:'pwd'/depot_tools
gclient config http://dart.googlecode.com/svn/branches/1.1/deps/all.deps
gclient sync
gclient runhooks
cd dart
tools/build.py --mode=release --arch=x64 create_sdk
