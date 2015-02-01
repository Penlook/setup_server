#!/bin/bash
TMP=/usr/local/src
sudo mkdir -p $TMP
cd $TMP
wget https://storage.googleapis.com/dart-archive/channels/stable/release/42828/sdk/dartsdk-linux-ia32-release.zip
tar -xvf dartsdk-linux-ia32-release.zip
rm -rf dartsdk-linux-ia32-release.zip
export PATH=$PATH:$TMP/dart-sdk/bin
export GOPATH=$HOME