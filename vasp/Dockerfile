FROM poryoung/intel-compiler-base

WORKDIR /workdir
COPY . /workdir/
RUN cd /workdir/vasp.5.4.4/ \
    && make all && echo "root:docker_vasp" | chpasswd && sed -i '6 s/^/#/' /root/.bashrc