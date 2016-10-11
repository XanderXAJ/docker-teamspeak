#!/bin/sh

# Stop server before restoring to prevent data inconsistency
docker inspect --type container teamspeak >/dev/null 2>&1 && docker stop teamspeak
docker run -it --rm --volume teamspeak:/data --volume "$(pwd):/backup" teamspeak bash -c "find /data -mindepth 1 -depth -delete && tar -xvf \"/backup/${1}\" -C /"
docker inspect --type container teamspeak >/dev/null 2>&1 && docker start teamspeak

