# Class: nvidia
# ===========================
#
# This module automates the installation of nvidia drivers.
# The module allows you to specify which version you want to install. It is also able to automatically detect the latest version.
#
#
# Parameters
# ----------
#
# * `version`
#  Specifies the version of the driver that should be installed. Default value is 'latest'.
#
# Examples
# --------
#
# @example
#    class { 'nvidia':
#      version => 'latest',
#    }
#
# Authors
# -------
#
# Henriette Kolby Rohde Garder <hkgarder@stud.ntnu.no>
# Sturla Høgdahl Bae <sturlaba@stud.ntnu.no>
#
# Copyright
# ---------
#
# Copyright 2018 Henriette K. Rohde Garder & Sturla H. Bae, unless otherwise noted.
#
class nvidia(Variant[Numeric, Enum['latest','recommended']] $version = 'latest') {
  $gpu_vendor = $::facts['gpu_vendor']            # Retrieves GPU vendor by looking up PCI vendor ID
  if $gpu_vendor =~ /NVIDIA/ {                    # Checks that a NVIDIA GPU is present
    case $facts['os']['name'] {                   # Retrieves OS name
      'Ubuntu': {
        class { 'nvidia::ubuntu':                 # If OS is Ubuntu, calls nvidia::ubuntu
          version => $version
        }
      }
      'windows': {
        class { 'nvidia::windows':                # If OS is Windows, calls nvidia::windows
          version => $version
        }
      }
      default: {
        fail('Error, OS not supported.')
      }
    }
  }
  else {
    #fail('No NVIDIA GPU detected')
  }
}
