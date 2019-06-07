define docker::container(
                          $ensure       = 'running',
                          $enable       = 'true',
                          $container_id = $name,
                        ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  file { "/etc/init.d/dockercontainer_${container_id}":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => file("${module_name}/container_init.sh"),
  }

  case $::osfamily
  {
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^7.*$/:
        {
          $systemd = true
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }

  if($systemd)
  {
    systemd::sysvwrapper { "dockercontainer_${container_id}":
      initscript => "/etc/init.d/dockercontainer_${container_id}",
      restart    => 'always',
      notify     => Service["dockercontainer_${container_id}"],
      before     => Service["dockercontainer_${container_id}"],
    }
  }

  service { "dockercontainer_${container_id}":
    ensure  => $ensure,
    enable  => $enable,
    require => File["/etc/init.d/dockercontainer_${container_id}"],
  }

}
