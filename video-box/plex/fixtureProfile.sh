#!/usr/bin/env bash
HOST_DIR="profiles"
IMG_DIR="/usr/lib/plexmediaserver/Resources/Profiles/"
IMG_NAME="plexinc/pms-docker:latest"
CONT_NAME="plex-tmp"

IMG_ID="$(docker images --format="{{.Repository}}:{{.Tag}} {{.ID}}" |  grep $IMG_NAME |  cut -d' ' -f2)"
if [ -z "$IMG_ID" ]; then
    echo "there no matching base image"
    exit 0
fi

CID=$(docker run -d --name $CONT_NAME $IMG_NAME)

docker cp $CID:$IMG_DIR /tmp/plex-fixture/

cp -a --no-clobber /tmp/plex-fixture/. $HOST_DIR

ls -la $HOST_DIR

rm -rf /tmp/plex-fixture/
docker stop $CID
docker rm $CID