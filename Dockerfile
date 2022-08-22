FROM centos:7
LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="systemd-centos7" \
    org.label-schema.vendor="fleurdeviande" \
    maintainer="fleurdeviande" \
    org.label-schema.build-date="2022-08-10"

ENV container docker

USER root:root

RUN yum install -y epel-release \
    && yum update -y \
    && yum install -y net-tools bind-utils date \
        iproute ansible sysstat nano htop openssh-clients \
        bash-completion tcpdump vim socat \
    &&  yum clean all; rm -rf /var/cache/yum

ADD container/healz /opt/container/healz
ADD container/entrypoint /opt/container/entrypoint
ADD container/forward-to-console.conf /etc/systemd/journald.conf.d/

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*; \
mkdir /etc/systemd/journald.conf.d/; \
chmod +x /opt/container/healz

STOPSIGNAL SIGRTMIN+3
HEALTHCHECK --interval=5s --timeout=15s --start-period=5s --retries=3 CMD [ "/opt/container/healz" ]
ENTRYPOINT ["/opt/container/entrypoint"]
