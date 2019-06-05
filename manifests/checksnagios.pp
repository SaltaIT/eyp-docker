class docker::checksnagios($base='/usr/local/bin') inherits docker::params {

  file { "${base}/check_data_allocated_docker_pool":
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/check_data_allocated_docker_pool",
  }

  file { "${base}/check_metadata_allocated_docker_pool":
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/check_data_allocated_docker_pool",
  }

}
