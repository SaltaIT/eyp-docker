#
class docker(
              $manage_package        = true,
              $package_ensure        = 'installed',
              $manage_service        = true,
              $manage_docker_service = true,
              $service_ensure        = 'running',
              $service_enable        = true,
              $install_nagios_checks = true,
            ) inherits docker::params {

  class { '::docker::install': } ->
  class { '::docker::config': } ~>
  class { '::docker::service': } ->
  Class['::docker']

}
