#!/bin/sh
# Remove any running instance
docker rm -f teamspeak > /dev/null 2>&1

# Run TeamSpeak server
docker run --name teamspeak --detach --restart unless-stopped --publish 9987:9987/udp --publish 10011:10011 --publish 30033:30033 --volume teamspeak:/data --memory 100m teamspeak
