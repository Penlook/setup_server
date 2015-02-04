#!/bin/sh
yum update
yum groupinstall -y 'Development Tools'
yum install -y curl nano git m4 bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel gcc libtool libtool-ltdl-devel
yum install -y automake autoconf ncurses-devel libxslt groff pckgconfig libedit libedit-devel
yum install -y pcre-devel clang pcre-devel
yum install -y git hg