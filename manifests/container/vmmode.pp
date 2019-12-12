define docker::container::vmmode(
                                  $container_name  = $name,
                                  $users           = undef,
                                  $withoutpassword = false,
                                ) {

  if(!defined(File['/usr/local/bin/dockerVMmode.sh']))
  {
    file { '/usr/local/bin/dockerVMmode.sh':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => file("${module_name}/dockerVMmode.sh"),
    }
  }

  file { "/usr/local/bin/${container_name}":
    ensure => 'link',
    target => '/usr/local/bin/dockerVMmode.sh',
  }

  if($users!=undef)
  {
    sudoers::sudo { "sudo docker VM mode ${users} ${container_name}":
      description     => "docker VM mode for ${container_name}",
      username        => $users,
      command         => "/usr/local/bin/${container_name}",
      withoutpassword => $withoutpassword,
    }
  }
}
