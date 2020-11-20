FROM python:3.8

WORKDIR /workdir

COPY ./aiida_setup.yml ./aiida_config.sh /workdir/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo " " > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ buster main" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-security buster/updates main" >> /etc/apt/sources.list \
    && apt-get clean -y && apt-get update \
    && apt-get install -y sshpass vim \
    && pip install aiida-core aiida-quantumespresso aiida-vasp -i https://mirrors.aliyun.com/pypi/simple/ \
    && reentry scan
# pip install aiida-core[atomic_tools]
ENV PROFILE_NAME=aiida
ENV SYSTEM_USER=root
ENV USER_EMAIL=ias@szu.edu.cn
ENV USER_FIRST_NAME=ias
ENV USER_LAST_NAME=ias
ENV USER_INSTITUTION=ias
ENV AIIDADB_BACKEND=django