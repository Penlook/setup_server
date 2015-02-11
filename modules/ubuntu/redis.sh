#!/bin/bash

# UPDATE FOR UBUNTU

# INSTALL ESSENTIAL
sudo apt-get update
sudo apt-get install tcl8.5 build-essential -y

# INSTALL REDIS
cd /tmp
wget http://download.redis.io/releases/redis-stable.tar.gz
tar -xvf redis-stable.tar.gz
cd redis-stable
make && sudo make install
cd utils
sudo ./install_server.sh
cd ../../
rm -rf redis-stable