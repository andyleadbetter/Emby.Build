#!/bin/bash
#================
# FILE          : config.sh
#----------------
# PROJECT       : OpenSuSE KIWI Image System
# COPYRIGHT     : (c) 2013 SUSE LLC
#               :
# AUTHOR        : Robert Schweikert <rjschwei@suse.com>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : configuration script for SUSE based
#               : operating systems
#               :
#               :
# STATUS        : BETA
#----------------
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]..."

#======================================
# Setup baseproduct link
#--------------------------------------
suseSetupProduct

#======================================
# SuSEconfig
#--------------------------------------
suseConfig

#======================================
# Import repositories' keys
#--------------------------------------
suseImportBuildKey

#======================================
# Umount kernel filesystems
#--------------------------------------
baseCleanMount

#======================================
# Disable recommends
#--------------------------------------
sed -i 's/.*installRecommends.*/installRecommends = no/g' /etc/zypp/zypper.conf

#======================================
# Remove locale files
#--------------------------------------
(pushd /usr/share/locale && find -name '*.mo' | xargs rm && popd)
(pushd /usr/lib/locale && find -maxdepth 1 -type d !  -name "C.utf8" -exec rm -rf {} \; && popd)
(pushd /usr/ && find -type d -name "gconv" -exec rm -rf {} \; && popd)
(pushd /etc/zypp/repos.d && find -type f -exec rm -rf {} \; && popd)

exit 0
