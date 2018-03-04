#!/bin/sh
# Backs up the teamspeak named volume
IMAGE=xanderxaj/teamspeak
now=$(date +%Y%m%d-%H%M%S)
echo "Backing up to backup_${now}.tar.bz2..."
docker run -it --rm --volume teamspeak:/data --volume "$(pwd):/backup" $IMAGE tar -acvf /backup/backup_${now}.tar.bz2 /data

