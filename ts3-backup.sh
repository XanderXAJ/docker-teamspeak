#!/bin/sh
# Backs up the teamspeak named volume
now=$(date +%Y%m%d-%H%M%S)
echo "Backing up to backup_${now}.tar.bz2..."
docker run -it --rm --volume teamspeak:/data --volume "$(pwd):/backup" teamspeak tar -acvf /backup/backup_${now}.tar.bz2 /data

