#!/bin/bash
# =========================================================================
# =========================================================================
#
#	netsurf-build.sh
#		Build the NetSurf binary and package in tarball.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.5.0
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
# Quick Build Steps for NetSurf
# =============================
#
# Last Updated: 15th December 2017
#
# This document provides steps for building NetSurf.
#
# Native build
# ============
#
# =========================================================================
#
# Grab a temporary env.sh
# -----------------------
#
#	wget https://git.netsurf-browser.org/netsurf.git/plain/docs/env.sh
	cp /pkg-repo/netsurf/env.sh .
	unset HOST
	source ./env.sh
	ns-package-install -y
	source ./env.sh
#
# Install any packages you need
# -----------------------------
#
#
# Installs all packages required to build NetSurf and the NetSurf project
# libraries.
#
###	ns-package-install -y
#
# If your package manager is not supported, you will have to install third
#  party packages manually.
#
# Get the NetSurf project source code from Git
# --------------------------------------------
#
# All the sources for the browser and support libraries is available
#  from the public git server.
#
#Local copies may be easily obtained with the ns-clone command.

	ns-clone
#
#
# Build and install our project libraries
# ---------------------------------------
#
# Updates NetSurf project library sources to latest, builds and installs them.
#
	ns-pull-install
#
#
# Switch to new NetSurf workspace
# -------------------------------
#
#Remove the bootstrap script and use the newly installed one
#
	rm ./env.sh
	cd ~/dev-netsurf/workspace
	source ./env.sh
#
#
# Build and run NetSurf
# ---------------------
#
 	cd netsurf
#
# To build the native front end (the GTK front end on Linux, BSDs, etc)
#  you could do:
#
	make

    mkdir -p usr/bin
    mkdir -p usr/share/netsurf

    cp ./nsgtk usr/bin
    cp -r ./resources/* usr/share/netsurf
    
    tar -cvf /pkg-repo/netsurf-3.8-deb-gtk-x86_64.tar.gz usr
    rm -R usr

	cd ~
exit 0
