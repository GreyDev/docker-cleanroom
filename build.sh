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

source=${1%/}
output=$2

echo "Generating build container..."
docker build -rm -no-cache -t "build-$output" $source|| {
    echo "Something went wrong when building the builder. Aborting."
    exit 1
}

echo "Build container finished. Generating root filesystem"
docker run build-$output cat /rootfs.tar > $source/rootfs/rootfs.tar

echo "Root filesystem generated. Building container."
docker build -rm -t "$output" $source/rootfs
echo "Building Docker image $2 complete."
