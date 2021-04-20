#!/bin/sh
#
# Script to identify the name of the newest NVIDIA GPU driver package
#
# @return The name of the newest NVIDIA gpu driver package
#
# Assumes that the packages will continue to be named in the same manner
#

if [ -d /etc/apt ] ;
then
 newest = $(apt-cache pkgnames nvidia-driver- | cut -d- -f3 | sort -nr | head -1)

 echo "nvidia-latest=$newest"			# Prints the name of the package

 if [ -x /usr/bin/ubuntu-drivers ] ;
 then
  recommended=$(/usr/bin/ubuntu-drivers devices | grep nvidia | grep recommended | awk '{print $3}')
 else
  recommended="nvidia-${newest}"
 fi
 echo "nvidia-recommended=$recommended"
fi
