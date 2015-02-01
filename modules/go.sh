#!/bin/bash
TMP=/usr/local/src
sudo mkdir -p $TMP
cd $TMP
wget https://storage.googleapis.com/golang/go1.4.1.src.tar.gz
tar -xvf go1.4.1.src.tar.gz
rm -rf go1.4.1.src.tar.gz
cd go/src
sudo ./all.bash
PATH=$PATH:$TMP/go/bin
export $PATH
GOPATH=$HOME
export $GOPATH
