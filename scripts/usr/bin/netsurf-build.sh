#!/bin/bash
# =========================================================================
# =========================================================================
#
#	netsurf-build.sh
#		Build the NetSurf binary and package in tarball.
#
#		A function based upon the original script provided by
#		NetSurf.org.  Very little re-writing was performed.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.2
# @copyright © 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-netsurf
# @subpackage Dockerfile
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

. /usr/local/lib/lms/lmsconCli-0.0.2.bash
. /usr/local/lib/lms/lmsBuildNS-0.0.1.sh

# =========================================================================
#
#
#
# =========================================================================
nsLoadScript "${nsUrl}""${nsEnv}"
[[ $? -eq 0 ]] ||
 {
 	lmsconDisplay "nsLoadScript failed: nsUrl = \"${nsUrl}\", nsEnv = \"${nsEnv}""
 	exit 1
 }

nsBuildApp "${nsEnv}" "${wsRoot}/${ws_Path}"
[[ $? -eq 0 ]] ||
 {
 	lmsconDisplay "nsBuildApp failed: nsEnv = \"${nsEnv}\", nsEnv = \"${nsEnv}""
 	exit 2
 }

mkdir -p usr/bin
mkdir -p usr/share/netsurf

cp ./nsgtk usr/bin
cp -r ./resources/* usr/share/netsurf

tar -cvf ${nsArchive} usr
rm -R usr

cd ~


lmsconDisplay "\"${nsUrl}\" successfully created."

exit 0
