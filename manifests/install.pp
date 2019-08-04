class docker::install inherits docker {

  fail("TODO: docker-ce")

  if($docker::install_nagios_checks)
  {
    include ::docker::checksnagios
  }

  if($docker::manage_package)
  {
    package { $docker::params::package_name:
      ensure => $docker::package_ensure,
    }
  }
}
