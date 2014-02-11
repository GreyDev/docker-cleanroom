docker-cleanroom
================

This tools is designed to produce minimal busybox-based Docker container images using a cleanroom-style build environment.

Usage
---
First up, clone yourself a copy of the repository

```
git clone https://github.com/GreyDev/docker-cleanroom.git
cd docker-cleanroom
```

Next up we need to create our base build environment. This image contains a full image of Ubuntu, and building this will take care of the heavy lifting in installing `build-essentials` and other tools. This will speed up our builds considerably.

```
./contrib/build-ubuntu-dev/build.sh
```

Once we have our base build container, we can start being productive. Let's build our first container.

```
./build.sh <build scripts> <output container>
./build.sh build-busybox mybusybox
```

Hopefully, if all goes well we should see `Building Docker image busybox complete.`.  
We can test our image using standard Docker commands:

```
docker images
docker run -t -i mybusybox /bin/ash
```

And we're done!

Custom Containers
---

Custom containers can be created very simply. An example `build-httpd` has been supplied.  
The process is as follows:

1. A clean build environment is created using our custom ubuntu-dev as a base
2. A working directory for our Busybox root filesystem is created in `/rootfs`
3. We add `install/install.sh` into our build evironment
4. We create a container from the image, and run the install scrips.
5. `/rootfs.tar` is created from `/rootfs`
6. `/rootfs.tar` is extracted from the build environment
7. A final image is produced using the `rootfs.tar`
