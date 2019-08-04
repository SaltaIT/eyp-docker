class docker::config inherits docker {

  file { '/etc/docker/daemon.json':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/daemon_json.erb"),
  }

}
