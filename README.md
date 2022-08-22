# centos-systemd

This is system image that runs systemd and provides a basic system for testing and development purposes, such as testing
ansible role using molecule.
The image is built on top of the official CentOS 7 image.
It is systemd enabled and ready to test Ansible roles with Molecule or develop some software/infra with other tools.

## How to run systemd container manually

```docker run --name systemd --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d fleurdeviande/centos-systemd```

Note that systemd expects `/run` and `/tmp` to be writable and `/sys/fs/cgroup` mounted and readable.

## Apple Silicon(M1)

Due issue with cgroupv2 on MacOS with M1 and Docker 4.11.1 (84025)
described [here](https://github.com/docker/for-mac/issues/6073)
to successfully run the systemd container, you need to switch back on cgroupv1 by adding `"deprecatedCgroupv1": true` to
`~/Library/Group\ Containers/group.com.docker/settings.json` file and restart Docker.

## Why we do have socat in this image?

We need to run socat to forward the logs from systemd stream to the docker logs so that you can see everything
from the `docker logs` command.

**Example**
![docker logs](files/docker-logs.png)

## Software installed by default in the image

- systemd
- ansible
- net-tools
- iproute
- sysstat
- nano
- htop
- openssh-clients
 - bash-completion
 - tcpdump
 - vim
 - socat
