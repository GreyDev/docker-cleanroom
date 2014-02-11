FROM ubuntu-dev
RUN mkdir /rootfs
WORKDIR /rootfs

RUN mkdir bin etc dev dev/pts lib proc sys tmp www
RUN touch etc/resolv.conf
RUN cp /etc/nsswitch.conf etc/nsswitch.conf
RUN echo root:x:0:0:root:/:/bin/sh > etc/passwd
RUN echo root:x:0: > etc/group
RUN echo nobody:x:1:1:nobody:/:/bin/false > etc/passwd
RUN echo nobody:x:1: > etc/group
RUN ln -s lib lib64
RUN ln -s bin sbin
RUN cp /bin/busybox bin
RUN for X in $(busybox --list) ; do ln -s busybox bin/$X ; done
RUN bash -c "cp /lib/x86_64-linux-gnu/lib{c,dl,nsl,nss_*,pthread,resolv,rt,crypt}.so.* lib"
RUN cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib

ADD build.sh /tmp/build.sh
RUN /tmp/build.sh

RUN tar cf /rootfs.tar .
RUN for X in console null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done

EXPOSE 80
CMD ["/sbin/thttpd", "-d", "/www", "-D"]
