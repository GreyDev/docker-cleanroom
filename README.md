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
./contrib/build-ubuntu-dev/build
```

Once we have our base build container, we can start being productive. Let's build our first container.

```
./build.sh <build scripts> <output container>
./build.sh build-httpd mycontainer
```
