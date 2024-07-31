FROM --platform=linux/amd64 almalinux:9
RUN yum install -y epel-release  # extra packages (netcdf etc...)
RUN yum install -y boost-regex boost-filesystem xerces-c boost-program-options netcdf netcdf-cxx4  # dependencies
RUN mkdir /src
WORKDIR /src
RUN curl "https://archive.eol.ucar.edu/docs/software/aspen/AspenV4.0.2_AlmaLinux9.4_x86_64.tar.gz" | tar -xzf -
WORKDIR /src/AspenV4.0.2_AlmaLinux9.4_x86_64/bin/
ENTRYPOINT ["./Aspen-QC"]
CMD ["-i", "-e"]
