#
# Installs NVIDIA GPU drivers on Ubuntu.
# Desired version of the driver is passed as parameter.
#
class nvidia::ubuntu (
  Variant[Numeric, Enum['latest','recommended']] $version = 'latest'
) {
  case $version {
    'latest': {
      # Automatically finds the newest nvidia package
      $pkg_name = "nvidia-driver-${::facts['nvidia-latest']}"
    }
    'recommended': {
      $pkg_name = $::facts['nvidia-recommended']
    }
    default: {
      $nvidia_version = $version
      $pkg_name = "nvidia-driver-${version}"
    }
  }

  package { $pkg_name:
    ensure => installed,
  }
}
