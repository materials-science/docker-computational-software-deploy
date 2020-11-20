FROM poryoung/intel-compiler-build AS build

FROM ubuntu:16.04

COPY --from=build /opt/intel /opt/intel
# Set paths for intel libraries, so that we can use them during docker build
ENV INTELPATH /opt/intel
ENV MKLROOT ${INTELPATH}/mkl
ENV INTEL_LICENSE_FILE ${INTELPATH}/licenses
ENV LIBRARY_PATH ${INTELPATH}/tbb/lib/intel64_lin/gcc4.7:${INTELPATH}/compilers_and_libraries/linux/lib/intel64_lin:${MKLROOT}/lib/intel64_lin
ENV MPI_HOME ${INTELPATH}/compilers_and_libraries_2018.5.274/linux/mpi
ENV LD_LIBRARY_PATH $MPI_HOME/lib:${INTELPATH}/compilers_and_libraries/linux/lib/intel64_lin:${LIBRARY_PATH}
ENV CPATH ${MKLROOT}/include
ENV NLSPATH ${INTELPATH}/compilers_and_libraries_2018.5.274/linux/lib/intel64/locale/%l_%t/%N:${MKLROOT}/lib/intel64_lin/locale/%l_%t/%N
ENV PATH ${INTELPATH}/bin:${MPI_HOME}/bin:${MKLROOT}/bin:${INTELPATH}/impi/2018.4.274/bin64:${PATH}
ENV PKG_CONFIG_PATH ${MKLROOT}/bin/pkgconfig
ENV MKL_LIB_PATH ${MKLROOT}/lib/intel64

WORKDIR /workdir

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean && apt-get update \
    && apt-get install -y \
        apt-transport-https \
        build-essential \
        openssl \
        rsync \
        wget \
        ssh \
        openssh-server \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && /etc/init.d/ssh start
# RUN source /opt/intel/bin/compilervars.sh intel64 \
#     && source /opt/intel/mkl/bin/mklvars.sh intel64 \
#     && source /opt/intel/impi/2018.4.274/bin64/mpivars.sh intel64 \
#     && source /opt/intel/compilers_and_libraries_2018.5.274/linux/bin/iccvars.sh intel64 \
#     && source /opt/intel/compilers_and_libraries_2018.5.274/linux/bin/ifortvars.sh intel64