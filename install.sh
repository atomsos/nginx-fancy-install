#!/bin/bash



version=$(nginx -v 2>&1 | cut -d '/' -f 2)
nginx_dir=nginx-$(version)
nginx_fname=nginx-$(version).tar.gz
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

cd $nginx_dir
./configure $(nginx -V 2>&1 | grep configure | cut -d ':' -f 2) --add-module=../ngx-fancyindex


make -j4

# sudo make install

