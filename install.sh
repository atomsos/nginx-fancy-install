#!/bin/bash

# This script needs nginx installed already
if [ ! -x "$(command -v nginx)" ]; then
  echo "Please install nginx with"
  echo "    sudo yum install -y nginx"
  echo "before using this script"
  exit 1
fi


version=$(nginx -v 2>&1 | cut -d '/' -f 2)
if [[ "$version" ~= ' ' ]]; then
  version=$(echo $version | cut -d ' ' -f 1)
fi
echo version: $version



nginx_dir=nginx-${version}
nginx_fname=nginx-${version}.tar.gz
wget -4 -c http://nginx.org/download/${nginx_fname}
tar zxf $nginx_fname


git clone --depth 1 https://github.com/aperezdc/ngx-fancyindex.git ngx-fancyindex


sudo yum install -y \
libxml2 libxml2-devel \
libxslt libxslt-devel \
gd gd-devel \
perl-ExtUtils-Embed \
GeoIP-devel \
gperftools-libs gperftools-devel \
pcre-devel \
openssl-devel


sudo apt install -y libxml2
sudo apt install -y libxml2-dev
sudo apt install -y libxslt
sudo apt install -y libxslt-dev
sudo apt install -y libgd
sudo apt install -y libgd-dev
sudo apt install -y perl-ExtUtils-Embed
sudo apt install -y libgeoip-dev
sudo apt install -y gperftools-libs
sudo apt install -y gperftools-dev
sudo apt install -y pcre-dev
sudo apt install -y libpcre3
sudo apt install -y libpcre3-dev
sudo apt install -y openssl
sudo apt install -y libssl-dev
sudo apt install -y zlib1g.dev





cd $nginx_dir
echo "./configure $(nginx -V 2>&1 | grep configure | cut -d ':' -f 2) --add-module=../ngx-fancyindex"
bash -c "./configure $(nginx -V 2>&1 | grep configure | cut -d ':' -f 2) --add-module=../ngx-fancyindex"


make -j4


echo "install with "
echo "    cd $nginx_dir; sudo make install"
# sudo make install

