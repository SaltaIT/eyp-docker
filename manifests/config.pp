class docker::config inherits docker {

  if($docker::manage_config)
  {
    file { '/etc/docker/daemon.json':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/daemon_json.erb"),
    }
  }

}
