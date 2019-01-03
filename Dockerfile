# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for ewsdocker/debian-netsurf-packager-packager in a 
#		Debian docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.6.0
# @copyright © 2018, 2019. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-netsurf-packager
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2018, 2019. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-netsurf-packager.
#
#   ewsdocker/debian-netsurf-packager is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-netsurf-packager is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-netsurf-packager.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-base:9.6.0

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================

ENV NETSURF_VERS="3.8"
ENV NETSURF_BUILD=1

# =========================================================================

ENV LMSBUILD_VERSION="9.6.0" 

ENV LMSBUILD_NAME=debian-netsurf-packager 
ENV LMSBUILD_REPO=ewsdocker 
ENV LMSBUILD_REGISTRY="" 

ENV LMSBUILD_PARENT="debian-base:9.6.0"

ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}, NetSurf ${NETSURF_VERS}, Build #${NETSURF_BUILD}"

# =========================================================================

ENV LMSOPT_DEBUG=0
ENV LMSOPT_QUIET=1
ENV LMSOPT_REMOVE=1

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
               bash-completion \
               gcc \
               libcurl3-dev \
               libgtk2.0-dev \
               libjpeg-dev \
               libmozjs-24-dev \
               libpng-dev \
               librsvg2-dev \
               make \
 && apt-get clean all \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

COPY scripts/. /

RUN chmod -R +x /usr/local/bin/* \
 && chmod +x /usr/bin/lms/netsurf-build.sh \
 && chmod 644 /usr/local/share/applications/${LMSBUILD_NAME}-${LMSBUILD_VERSION}.desktop \
 && chmod 644 /usr/local/share/applications/${LMSBUILD_NAME}.desktop \
 && ln -s /usr/bin/lms/netsurf-build.sh /usr/bin/lms-buildns 

# =========================================================================

ENTRYPOINT ["/my_init","--quiet"]
CMD ["lms-buildns"]
