## ewsdocker/debian-netsurf-packager:9.5.3  
**A NetSurf Internet browser packager for Debian in a Docker image.**  

**Pre-built Docker images are available from [ewsdocker/debian-netsurf-packager](https://hub.docker.com/r/ewsdocker/debian-netsurf-packager).**  

____  
#### Overview  
**ewsdocker/debian-netsurf-packager** implements the build script for the 
[NetSurf](http://www.netsurf-browser.org/) browser for Linux, with the GTK 
[NetSurf](http://www.netsurf-browser.org/) front-end, to create a <b>Debian 9</b>-based [NetSurf](http://www.netsurf-browser.org/) browser.  

The NetSurf browser <b>must</b> be compiled from original source in order to use it.  This provides a challenge for many whose only desire is to experiment with the browser, not learn how to build it. Creating an installation package for a given OS release can be very time consuming, especially if the product must be supported over a range of releases. is compiled for use on a Debian-based (v 9.5+) operation system by:  
1. Downloading the provided b
The compiled application binary and support libraries are packaged in a tar-ed, gzip-ed archive, which is used to create a Debian-based installation package (<b>.deb</b>) file. 

The **ewsdocker/debian-netsurf-packager** downloads the latest build script for the Open Source [NetSurf](http://www.netsurf-browser.org/) browser for <b>Debian</b> platform, compiles and builds the latest NetSurf browser and packages the resultant binary and required libraries into a tarball, which is then converted to a Debian package for installation in a Debian 9 operating system or container os.  

____  
#### NOTE  
**ewsdocker/debian-netsurf-packager** is designed to be used on a Linux system configured to support **Docker user namespaces** .  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and information on running **ewsdocker/debian-netsurf-packager** on a system not configured for **Docker user namespaces**.
____  

**Visit the [ewsdocker/debian-netsurf-packager Wiki](https://github.com/ewsdocker/debian-netsurf-packager/wiki/QuickStart) for complete documentation of this docker image.**  
____  

#### Installing ewsdocker/debian-netsurf-packager  

The following scripts will download the selected **ewsdocker/debian-netsurf-packager** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The _default_ values will install all directories and contents in the **docker host** user's home directory (refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf-packager/wiki/QuickStart#mapping)),  

____  
**ewsdocker/debian-netsurf-packager:latest**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -e LMSBUILD_VERSION=latest \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-packager-latest:/root \
               --name=debian-netsurf-packager-latest \
           ewsdocker/debian-netsurf-packager:latest lms-setup  

____  
**ewsdocker/debian-netsurf-packager:9.5.3**  
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-packager-9.5.3:/root \
               --name=debian-netsurf-packager-9.5.3 \
           ewsdocker/debian-netsurf-packager:9.5.3 lms-setup  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf-packager/wiki/QuickStart#mapping) for a discussion of **lms-setup** and what it does.  

____  
#### Running the installed scripts  

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

+ the executable scripts have been copied to **~/bin**;  
+ the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
+ the associated **debian-netsurf-packager-"version"** execution script(s) (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names.  

____  
**ewsdocker/debian-netsurf-packager:latest**
  
    docker run -it \
               --rm \
               -v /etc/localtime:/etc/localtime:ro \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/pkg-repo:/pkg-repo \
               -v ${HOME}/workspace-debian-netsurf-packager-latest:/workspace \
               -v ${HOME}/.config/docker/debian-netsurf-packager-latest:/root \
               -e LMSOPT_QUIET=0 \
               -e LMSOPT_DEBUG=0 \
               --name=debian-netsurf-packager-latest \
           ewsdocker/debian-netsurf-packager:latest  

____  
**ewsdocker/debian-netsurf-packager:9.5.3**
  
    docker run -it \
               --rm \
               -v /etc/localtime:/etc/localtime:ro \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v ${HOME}/pkg-repo:/pkg-repo \
               -v ${HOME}/workspace-debian-netsurf-packager-9.5.3:/workspace \
               -v ${HOME}/.config/docker/debian-netsurf-packager-9.5.3:/root \
               -e LMSOPT_QUIET=0 \
               -e LMSOPT_DEBUG=0 \
               --name=debian-netsurf-packager-9.5.3 \
           ewsdocker/debian-netsurf-packager:9.5.3  

____  
Refer to [Mapping docker host resources to the docker container](https://github.com/ewsdocker/debian-netsurf-packager/wiki/QuickStart#mapping) for a discussion of customizing the executable scripts..  

____  
#### Regarding edge  

For the very brave, if an _edge_ tag is available, these instructions will download, rename and install the _edge_ version.  Good luck.  

____  
**ewsdocker/debian-netsurf-packager:edge**  

**edge** is the development tag for the **9.5.4** release tag.

    docker pull ewsdocker/debian-netsurf-packager:edge
    docker tag ewsdocker/debian-netsurf-packager:edge ewsdocker/debian-netsurf-packager:9.5.4
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-netsurf-packager-9.5.4:/root \
               --name=debian-netsurf-packager-9.5.4 \
           ewsdocker/debian-netsurf-packager:9.5.4 lms-setup  

optional step:

    docker rmi ewsdocker/debian-netsurf-packager:edge  

To create and run the container, the following should work from the command-line, 

    ~/.local/bin/debian-netsurf-packager-9.5.4  

or,  

    docker run -v /etc/localtime:/etc/localtime:ro \
           -e DISPLAY=unix${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
           -v ${HOME}/public_html:/html-source \
           -v ${HOME}/.config/docker/debian-netsurf-packager-9.5.4:/root \
           --name=debian-netsurf-packager-9.5.4 \
       ewsdocker/debian-netsurf-packager:9.5.4    

____  
#### Persistence  
In order to persist the **debian-netsurf-packager** application state, a location on the docker _host_ must be provided to store the necessary information.  This can be accomplished with the following volume option in the run command:

    -v ${HOME}/.config/docker/debian-netsurf-packager-"version":/root  

Since the information is stored in the docker _container_ **/root** directory, this statement maps the user's **~/.config/docker/debian-netsurf-packager-"version"** docker _host_ directory to the **/root** directory in the docker _container_.  

____  
#### Timestamps  
It is important to keep the time and date on docker _host_ files that have been created and/or modified by the docker _containter_ synchronized with the docker _host_'s settings. This can be accomplished as follows:

    -v /etc/localtime:/etc/localtime:ro  

____  
**Copyright © 2018. EarthWalk Software.**  
**Licensed under the GNU General Public License, GPL-3.0-or-later.**  

This file is part of **ewsdocker/debian-netsurf-packager**.  

**ewsdocker/debian-netsurf-packager** is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

**ewsdocker/debian-netsurf-packager** is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License
along with **ewsdocker/debian-netsurf-packager**.  If not, see 
<http://www.gnu.org/licenses/>.  

