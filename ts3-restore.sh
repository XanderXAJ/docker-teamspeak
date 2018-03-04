#!/bin/sh

# Archive must be specified and readable
[ $# -eq 0 -o ! -r "$1" ] && {
  echo "Usage: $0 <archive>"
  exit 1
}

IMAGE=xanderxaj/teamspeak

# Stop server before restoring to prevent data inconsistency
docker inspect --type container $IMAGE >/dev/null 2>&1 && docker stop $IMAGE
docker run -it --rm --volume teamspeak:/data --volume "$(pwd):/backup" $IMAGE bash -c "find /data -mindepth 1 -depth -delete && tar -xvf \"/backup/${1}\" -C /"
docker inspect --type container $IMAGE >/dev/null 2>&1 && docker start $IMAGE
