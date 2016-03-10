#
class docker(
              $insecure_registry=undef,
              $insecure_registry_port="80",
              $devs=undef,
              $volumegroup=undef,
            ) inherits docker::params {

  #
  package { $docker_package:
    ensure => 'installed',
  }

  file { '/etc/sysconfig/docker':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/sysconfig/docker.erb"),
    notify  => Service['docker'],
    require => Package[$docker_package],
  }

  if($devs!=undef)
  {
    file { '/etc/sysconfig/docker-storage-setup':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/sysconfig/docker_storage.erb"),
      notify  => Exec['docker-storage-setup'],
      require => Package[$docker_package],
    }

    exec { 'docker-storage-setup':
      command     => '/usr/bin/docker-storage-setup',
      refreshonly => true,
      notify      => Service['docker'],
    }
  }


  service { 'docker':
    ensure => 'running',
    enable => true,
  }


}
