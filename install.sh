#!/bin/bash

# This script needs nginx installed already
if [ ! -x "$(command -v nginx)" ]; then
  echo "Please install nginx with"
  echo "    sudo yum install -y nginx"
  echo "before using this script"
  exit 1
fi


version=$(nginx -v 2>&1 | cut -d '/' -f 2)
nginx_dir=nginx-${version}
nginx_fname=nginx-${version}.tar.gz
wget -c http://nginx.org/download/${nginx_fname}
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




cd $nginx_dir
bash -c "./configure $(nginx -V 2>&1 | grep configure | cut -d ':' -f 2) --add-module=../ngx-fancyindex"


make -j4


echo "install with "
echo "    cd $nginx_dir; sudo make install"
# sudo make install

