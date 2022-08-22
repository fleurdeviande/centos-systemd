# centos-systemd

This is system image that runs systemd and provides a basic system for testing and development purposes, such as testing
ansible role using molecule.
The image is built on top of the official CentOS 7 image.
It is systemd enabled and ready to test Ansible roles with Molecule or develop some software/infra with other tools.

## How to run systemd container manually
```docker run --name systemd --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d fleurdeviande/centos-systemd```

Note that systemd expects `/run` and `/tmp` to be writable and `/sys/fs/cgroup` mounted and readable.

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
