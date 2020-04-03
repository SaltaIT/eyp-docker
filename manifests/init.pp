#
class docker(
              $manage_package                = true,
              $package_ensure                = 'installed',
              $manage_service                = true,
              $manage_docker_service         = true,
              $service_ensure                = 'running',
              $service_enable                = true,
              $manage_config                 = true,
              $install_nagios_checks         = true,
              $storage_driver                = 'overlay2',
              $inter_container_communication = false,
              $log_level                     = 'info',
              $live_restore                  = true,
              $iptables                      = true,
              $userland_proxy                = false,
              $no_new_privileges             = true,
              $bridge_ip                     = undef,
            ) inherits docker::params {

  class { '::docker::install': } ->
  class { '::docker::config': } ~>
  class { '::docker::service': } ->
  Class['::docker']

}
