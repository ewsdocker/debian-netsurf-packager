# =========================================================================
# =========================================================================
#
#	lmsconDisplay
#     display a message on the console and/or to a log file
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.2
# @copyright © 2016, 2018. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-kaptain-menu
# @subpackage lmsconDisplay
#
# =========================================================================
#
#	Copyright © 2016, 2018. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-kaptain-menu.
#
#   ewsdocker/debian-kaptain-menu is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-kaptain-menu is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-kaptain-menu.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================

declare    lmscon_buffer=""
declare    lmscli_optQuiet=0
declare    lmscli_optDebug=1

# =========================================================================
#
#   lmsconDisplay
#		display message on the console
#
#	parameters:
#		message = message to display
#	returns:
#		0 = no errors
#		non-zero = error code
#
# =========================================================================
function lmsconDisplay()
{
    lmscon_buffer="${1}"

    [[ ${lmscli_optQuiet} -eq 0 ]] || return 0

    [[ -z "${2}" ]] && echo "${lmscon_buffer}" || echo -n "${lmscon_buffer}"
}

# =========================================================================
#
#   lmsconDisplay_Debug
#		display debug message on the console
#
#	parameters:
#		message = message to display
#	returns:
#		0 = no errors
#		non-zero = error code
#
# =========================================================================
function lmsconDisplay_Debug()
{
    [[ ${lmscli_optDebug} -ne 0 && ${lmscli_optQuiet} -eq 0 ]] &&
     {
		lmsconDisplay "###########################"
		lmsconDisplay "#"
		lmsconDisplay "#   ${1}"
		lmsconDisplay "#"
		lmsconDisplay "###########################"
	 }
	
	return 0
}
