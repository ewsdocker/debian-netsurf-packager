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

declare lmsBuildNs_Ver="0.0.1"

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
	lmsconDisplay_Debug "nsLoadScript \"${1}\" \"${2}\""

	local scriptUrl="${1}"
	local scriptEnv="${2}"

	[[ -z "${scriptUrl}" || -z "${scriptEnv}" ]] &&
	 {
	 	lmscli_optQuiet=0
		lmsconDisplay "nsLoadScript ERROR: missing required parameter(s)"
	 	return 1
	 }
	
    # =====================================================================

	wget "${scriptUrl}"
    [[ $? -eq 0 ]] || 
     {
     	lmscli_optQuiet=0
		lmsconDisplay "nsLoadScript ERROR: wget failed."
     	return 2
     }

    # =====================================================================

	sed -i -e 's/apt-get install/apt-get -y install/g' ./env.sh

    # =====================================================================

	unset HOST

	lmsconDisplay_Debug "nsLoadScript completed"

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
	lmsconDisplay_Debug "nsBuildApp = \"${1}\" \"${2}\""

    # =====================================================================

	local loaderPath="${1}"
	local ws="${2}"
	
	[[ -z "${loaderPath}"  || -z "${ws}" ]] && 
	 {
	 	lmscli_optQuiet=0
		lmsconDisplay "nsBuildApp ERROR: missing required parameter(s)"
	 	return 1
	 }

    # =====================================================================

	lmsconDisplay_Debug "source loaderPath"

	source "${loaderPath}"

    # =====================================================================

	lmsconDisplay_Debug "calling ns-package-install"

	ns-package-install -y

    # =====================================================================

	lmsconDisplay_Debug "source env.sh"

	source ./env.sh

    # =====================================================================

	lmsconDisplay_Debug "calling ns-package-install"

	ns-package-install -y

    # =====================================================================

	lmsconDisplay_Debug "calling source ns-clone"

	ns-clone

    # =====================================================================

	lmsconDisplay_Debug "calling ns-pull-install"

	ns-pull-install

    # =====================================================================

	lmsconDisplay_Debug "remove env.sh, PWD = $PWD"

	rm ./env.sh

    # =====================================================================

	lmsconDisplay_Debug "nsBuildApp: cd = ${ws}, PWD = $PWD"

	cd "${ws}"

    # =====================================================================

	lmsconDisplay_Debug "source env.sh"

	source ./env.sh

    # =====================================================================

	lmsconDisplay_Debug "cd netsurf, PWD = $PWD"

 	cd netsurf

    # =====================================================================

	lmsconDisplay_Debug "make"

	make
	[[ $? -eq 0 ]] || 
     {
	 	lmscli_optQuiet=0
		lmsconDisplay "nsBuildApp ERROR: make failed."
	 	return 2
	 }

    # =====================================================================

	lmsconDisplay_Debug "nsBuildApp complete"

	return 0
}

