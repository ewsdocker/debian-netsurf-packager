#!/bin/bash
# =========================================================================
# =========================================================================
#
#	lmsBuildNS.sh
#
#		Build the NetSurf binary and package in tarball.
#
#		A function based upon the original script provided by
#		NetSurf.org.  Very little re-writing was performed.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-netsurf
# @subpackage lmsBuildNS
#
# =========================================================================
#
#	Copyright © 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-netsurf.
#
#   ewsdocker/debian-netsurf is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-netsurf is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-netsurf.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
#
# NOTE: 
#
#    slightly modified version of the original script to fix 2 items:
#      - script could not run unattended (apt-get install paused waiting
#          for confirmation)
#      - script does not package the built result in a useable manner
#          - creates a tgz of the required files to install NetSurf
#              as a binary
#
# =========================================================================
# =========================================================================

declare lmsBuildNsVer="0.0.1"

declare nsURL="https://git.netsurf-browser.org/netsurf.git/plain/docs/env.sh"
declare nsRepo="/pkg-repo"

declare nsArchName="netsurf-${NETSURF_VERS}-deb-gtk-x86_64.tar.gz"
declare nsArchive="${nsRepo}/${nsArchName}"

declare nsEnv="${nsRepo}/env.sh"

declare wsRoot="${HOME}"
declare wsPath="dev-netsurf/workspace"

# =========================================================================
#
#   nsLoadScript
#
#   input:
#       scriptUrl = path to the install loader script
#       scriptEnv = location to store loaded script
#   output:
#       0 = no error
#       non-zero = error code
#
# =========================================================================
function nsLoadScript()
{
	local scriptUrl="${1}"
	local scriptEnv="${2}"

	[[ -z "${scriptUrl}" || -z "${scriptEnv}" ]] && return 1
	
	wget "${scriptUrl}"
    [[ $? -eq 0 ]] || return 2

    while read buffer
    do 

    	echo ${buffer//apt-get install/apt-get -y install}

    done < ./env.sh > "${scriptEnv}"

	unset HOST
	
	return 0
}

# =========================================================================
#
#   nsBuildApp
#
#   input:
#       scriptUrl = path to the install loader script
#   output:
#       0 = no error
#       non-zero = error code
#
# =========================================================================
function nsBuildApp()
{
	local loaderPath="${1}"
	[[ -z "${loaderPath}" ]] && return 1

	local ws="${2}"
	
	source "${loaderPath}"

	ns-package-install -y
	source ./env.sh

	ns-clone
	ns-pull-install

	rm ./env.sh

	cd "${ws}"
	source ./env.sh

 	cd netsurf
	make
	
	return $?
}

