FROM poryoung/intel-compiler-base

WORKDIR /workdir

COPY ./qe-6.5/. /workdir/

RUN ./configure --prefix= CC=mpiicc CXX=icpc F77=ifort F90=ifort FC=ifort MPIF90=mpiifort FCFLAGS=-O2 CFLAGS=-O2 FFLAGS=-O2 --with-scalapack=intel
RUN make all && make install && echo "root:docker_qe" | chpasswd && sed -i '6 s/^/#/' /root/.bashrc
