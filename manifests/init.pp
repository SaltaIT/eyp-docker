#
class docker ($insecure_registry=undef, $insecure_registry_port="80" )
  inherits docker::params {

  #
  package { $docker_package:
    ensure => 'installed',
  }

  file { '/etc/sysconfig/docker':
    ensure => 'present',
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template("${module_name}/sysconfig_docker.erb"),
    notify => Service['docker'],
    require => Package[$docker_package],
  }

  service { 'docker':
    ensure => 'running',
    enable => true,
  }


}
