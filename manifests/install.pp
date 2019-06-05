class docker::install inherits docker {
  if($docker::manage_package)
  {
    package { $docker::params::package_name:
      ensure => $docker::package_ensure,
    }
  }
}
