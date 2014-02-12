#!/bin/bash

mkdir /rootfs
cd /rootfs
mkdir bin etc dev dev/pts lib proc sys tmp www
touch etc/resolv.conf
cp /etc/nsswitch.conf etc/nsswitch.conf
echo root:x:0:0:root:/:/bin/sh > etc/passwd
echo root:x:0: > etc/group
echo nobody:x:1:1:nobody:/:/bin/false > etc/passwd
echo nobody:x:1: > etc/group

mkdir etc/init.d
mkdir etc/rc.d

cp /tmp/inittab etc/
#rcS defines the init scripts
cp /tmp/rcS etc/init.d/
#an init script
cp /tmp/S50init etc/rc.d/

ln -s lib lib64
ln -s bin sbin
cp /bin/busybox bin
for X in $(busybox --list) ; do ln -s busybox bin/$X ; done
bash -c "cp /lib/x86_64-linux-gnu/lib{c,dl,nsl,nss_*,pthread,resolv,rt,crypt}.so.* lib"
cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib

cd /tmp
wget http://opensource.dyc.edu/pub/sthttpd/sthttpd-2.26.4.tar.gz
tar xvzf sthttpd-2.26.4.tar.gz
cd sthttpd-2.26.4
./configure --prefix=/rootfs > configure.log
make && make install > make.log

cd /rootfs
tar cf /rootfs.tar .
for X in console null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done

