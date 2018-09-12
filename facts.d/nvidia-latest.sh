#!/bin/sh
#
# Script to identify the name of the newest NVIDIA GPU driver package
#
# @return The name of the newest NVIDIA gpu driver package
#
# Assumes that the packages will continue to be named in the same manner
#

packages=$(apt-cache pkgnames nvidia-) 	# Retrieves all packages where the name contains "nvidia-"
newest=0

versions=$(
	for p in  $packages; do		# Selects all who are named "nvidia-X", where X is a number
		if [ $(echo $p | egrep "^nvidia-[0-9]+$") ]; then
			echo $(echo $p | cut -c8-)
		fi
	done
)

for v in $versions; do
	if [ $v -gt $newest ]; then	# Selects the highest number
		newest=$v
	fi
done

echo "nvidia-latest=$newest"			# Prints the name of the package

recommended=$(ubuntu-drivers devices | grep recommended | awk '{print $3}')
echo "nvidia-recommended=$recommended"
