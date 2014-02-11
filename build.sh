#!/bin/sh
[ "$1" ] || {
    echo "Specify build directory to use:"
    ls -1 -d build-*
    exit 1
}
[ "$2" ] || {
    echo "Specify an output image"
    exit 1
}
[ -d "$1" ] || {
    echo "Could not find directory $1."
    exit 1
}

echo "Generating build container..."
docker build -rm -no-cache -t "build-$2" $1|| {
    echo "Something went wrong when building the builder. Aborting."
    exit 1
}

echo "Build container finished. Generating root filesystem"
docker run build-$2 cat /rootfs.tar > $1/rootfs/rootfs.tar

echo "Root filesystem generated. Building container."
#[ -d $1/rootfs ] && rm -rf $1/rootfs
#mkdir $1/rootfs
#tar xf $1/rootfs.tar -C $1/rootfs

docker build -rm -t "$2" $1/rootfs/

echo "Building Docker image $2 complete."