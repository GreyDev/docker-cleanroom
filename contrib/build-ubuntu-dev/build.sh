#!/bin/sh
SCRIPTPATH=`dirname $0`
echo "Building..."
docker build -rm -no-cache -t "ubuntu-dev" $SCRIPTPATH|| {
    echo "Something went wrong when building the builder. Aborting."
    exit 1
}
echo "Build finished."
