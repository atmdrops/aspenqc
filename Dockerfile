FROM --platform=linux/amd64 centos:7
RUN yum install -y epel-release  # extra packages (netcdf etc...)
RUN yum install -y boost-regex boost-filesystem xerces-c boost-program-options netcdf netcdf-cxx  # dependencies
RUN mkdir /src
WORKDIR /src
RUN curl "https://archive.eol.ucar.edu/docs/software/aspen/AspenV3.4.9_CentOS7.9.2009_x86_64.tar.gz" | tar -xzf -
WORKDIR /src/AspenV3.4.9_CentOS7.9.2009_x86_64/bin/
ENTRYPOINT ["./Aspen-QC"]
CMD ["-i", "-e"]
