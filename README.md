# iperf3

iperf3 binaries taken from Alpine Linux 3.11, then ran in a container from scratch as *nobody* user. Lightweight and secure.

## Requirements

As of now, only ARM64 (AArch64) is supported but it would be easy to support more CPU architectures.
Tested on Raspberry Pi 4 with success.

## Running iperf3

The image is by default configured to run iperf3 as server by running ```iperf3 -s``` inside the container.
This allows you to spin up an iperf3 server like this:
```
docker run -d --restart unless-stopped -p 5201:5201/tcp -p 5201:5201/udp slynet/iperf3
```
However, it's also possible to override iperf3 arguments. For example, you can run iperf3 as client like this:
```
docker run -it slynet/iperf3 -c iperf.he.net
```

