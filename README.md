# ASPEN docker image

This repo generates a docker image for the [ASPEN](https://www.eol.ucar.edu/content/aspen) software.
ASPEN (Atmospheric Sounding Processing Environment) is developed by NCAR and used for analysis and quality control (QC) of sounding data.
In principle, the software can be run on a few operating systems.
However, hosting the software in form of a docker image makes it independent from the operating system which is the purpose of this repository.

The repository includes a `Dockerfile` and the respective GitHub workflows needed to generate the image and push it to the [GitHub container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
Currently, there is only the [ASPEN version 4.0.2](https://www.eol.ucar.edu/software/aspen) (Jun 7, 2024) available.
Older as well as newer versions could also be added in a similar way and you can open an issue if you would like to have them or add them yourself.

## Usage

**Prerequisite**: you need to install [`docker`](https://www.docker.com/) and start a docker daemon (`dockerd`) locally to be able to use the ASPEN docker image.
The simplest way would be to install `Docker Desktop` (on MacOS also possible via `brew install --cask docker`) and open the application before executing any docker command.

The name of the image is `ghcr.io/atmdrops/aspenqc`.

Run ASPEN and display the help statement:
```
docker run --rm -i ghcr.io/atmdrops/aspenqc --help
```

To process a single `Level_0` file (e.g. `D20240730_100114.1`)and write the output to stdout:
```
cat D20240730_100114.1 | docker run --rm -i ghcr.io/atmdrops/aspenqc
```

You can add a tag a the end to point to a specific version, e.g. `4.0.2` or `latest`.
For an overview of available versions/tags, have a look [here](https://github.com/atmdrops/aspenqc/pkgs/container/aspenqc).
```
cat D20240730_100114.1 | docker run --rm -i ghcr.io/atmdrops/aspenqc:4.0.2
```

### Generating a Level_1 netCDF files
The idea of docker is that you can run software detached from you local operating system.
Therefore, writing any generated output to your local disc is not straight forward, but possible via explicitly mounting a specified folder.
For details have a look at docker’s documentation on [bind mounts](https://docs.docker.com/storage/bind-mounts/).
TL;DR you need to specify a *source* directory (local) which the docker image can see and has access to and you also need to specify a *target*, which is the name of the source directory within the docker image.

An example would be:
```
docker run --rm --mount type=bind,source=path/to/dropsondes/data,target=/data ghcr.io/atmdrops/aspenqc -i /data/20240730/Level_0/D20240730_100114.1 -n /data/20240730/Level_1/D20240730_100114.1.nc
```
