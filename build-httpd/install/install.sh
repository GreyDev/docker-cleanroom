#!/bin/bash
wget http://opensource.dyc.edu/pub/sthttpd/sthttpd-2.26.4.tar.gz
tar xvzf sthttpd-2.26.4.tar.gz
cd sthttpd-2.26.4
./configure --prefix=/rootfs > configure.log
make && make install > make.log
