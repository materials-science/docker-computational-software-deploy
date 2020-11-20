FROM ubuntu:16.04

WORKDIR /workdir

RUN mv /etc/apt/sources.list /etc/apt/sources.list.old \
    && echo "deb http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted \ 
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted \
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial universe \
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates universe \
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial multiverse \
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates multiverse \
    deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse " >/etc/apt/sources.list \
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