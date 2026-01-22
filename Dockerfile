ARG ALMALINUX_VER=9.6
FROM --platform=linux/amd64 almalinux:${ALMALINUX_VER}
RUN yum install -y epel-release  # extra packages (netcdf etc...)
RUN yum install -y boost-regex boost-filesystem xerces-c boost-program-options netcdf netcdf-cxx4  # dependencies
RUN mkdir /src
WORKDIR /src
ARG ALMALINUX_VER=9.6
ARG ASPEN_VER=4.0.5
RUN curl "https://archive.eol.ucar.edu/docs/software/aspen/AspenV${ASPEN_VER}_AlmaLinux${ALMALINUX_VER}_x86_64.tar.gz" | tar -xzf -
WORKDIR /src/AspenV${ASPEN_VER}_AlmaLinux${ALMALINUX_VER}_x86_64/bin/
ENTRYPOINT ["./Aspen-QC"]
CMD ["-i", "-e"]
