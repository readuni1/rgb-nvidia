#
# Installs NVIDIA GPU drivers on Ubuntu.
# Desired version of the driver is passed as parameter.
#
class nvidia::ubuntu (Variant[Numeric, Enum['latest','recommended']] $version = 'latest') {
  case $version {
    'latest': {
      # Automatically finds the newest nvidia package
      $nvidia_version = $facts['nvidia-latest']
      $pkg_name = "nvidia-${facts['nvidia-latest']"
    }
    'recommended': {
      $pkg_name = $facts['nvidia-recommended']
    }
    default: {
      $nvidia_version = $version
      $pkg_name = "nvidia-${version}"
    }
  }

  package { $pkg_name:
    ensure => installed,
  }
}
