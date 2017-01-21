# docker-teamspeak

A nice and easy way to get a TeamSpeak server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on TeamSpeak and [check out its website][teamspeak].

[docker]: https://docs.docker.com/engine/getstarted/
[teamspeak]: http://teamspeak.com/

## Building docker-teamspeak

Running this will build you the latest docker-teamspeak image:

    git clone https://github.com/xanderxaj/docker-teamspeak
    cd docker-teamspeak
    ./ts3-build.sh

## Running docker-teamspeak

If nothing else is running on ports 9987, 10011 or 30033, launching TeamSpeak is a
simple case of running:

    ./ts3-run.sh

Note: If you get an error about being unable to gain access to docker, you may
need to add yourself to the `docker` group or prepend `sudo` to the `ts3-*` scripts
and all `docker` commands.

If the ports are in use, you can remap them by changing the ports in the teamspeak
container's `docker run` command.  Look for `-p=9987:9987/udp -p=10011:10011
-p=30033:30033` etc.

You can start and stop TeamSpeak by running:

    docker start teamspeak
    docker stop teamspeak

The TeamSpeak container will automatically launch on docker daemon startup or relaunch on
failure unless it has been stopped; this is via docker's `--restart unless-stopped` option.

## Restricted resource usage

The TeamSpeak container is limited to 100m of RAM and, where supported, 100m of swap.  Light testing
suggests this is good enough for most personal TS servers (i.e. with less than 20 users).  This can
be adjusted by modifying the `--memory` option in `ts3-start.sh`.

You may get a warning relating to limits on startup, for example:

    WARNING: Your kernel does not support swap limit capabilities, memory limited without swap.

This particular message means that RAM usage has been limited but swap has not.

To remove the warnings and enforce the limits, follow the instructions [in the Docker
docs][docker-memory] to enable support in your kernel.

[docker-memory]: https://docs.docker.com/engine/installation/linux/ubuntulinux/#adjust-memory-and-swap-accounting

## Managing TeamSpeak's data

The TeamSpeak server's data is stored in a named volume called `teamspeak`.

A backup with the current date and time can be created by running:

    ./ts3-backup.sh

That backup can be restored with:

    ./ts3-restore.sh <archiveName>

All data can be erased by deleting the `teamspeak` named volume; it'll be recreated when you next execute `ts3-run.sh`:

    docker volume rm teamspeak

## Server Admin Token

You can find the server admin token by running `docker logs teamspeak` upon first run of the server.
Search for "ServerAdmin privilege key created" and use that token on first connect.

### Notes on the run command

 + `-v` is the volume you are mounting `-v host_dir:docker_dir`
 + `teamspeak` is the name of the image built by `ts3-build.sh`
 + `-d` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p host_port:docker_port`

## Mumble Server Alternative

Benjamin Denhartog has created an alternative [MurMur/Mumble server][docker-mumble] if you're looking for an alternative to Teamspeak.

[docker-mumble]: https://github.com/bddenhartog/docker-murmur
