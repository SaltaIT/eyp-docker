class docker::registry($insecure=true) inherits docker::params {

  if(!$insecure)
  {
    fail('not implemented')
  }

  package { 'docker-registry':
    ensure => 'installed',
  }

  file { '/etc/sysconfig/docker-registry':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/sysconfig/docker_registry.erb"),
  }

  service { 'docker-registry':
    ensure  => 'running',
    enable  => true,
    require => [ Package['docker-registry'], File['/etc/sysconfig/docker-registry'] ],
  }
}
