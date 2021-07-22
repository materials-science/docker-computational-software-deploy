FROM ubuntu:16.04

WORKDIR /workdir

RUN cp /etc/apt/sources.list /etc/apt/sources.list.old \
    && sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        apt-transport-https \
        gcc \
        make \
        openssl \
        rsync \
        wget \
        ssh \
        openssh-server \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes /' /etc/ssh/sshd-config \
    && sed -i '6 s/^/#/' /root/.bashrc \
    && /etc/init.d/sshd start
