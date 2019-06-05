class docker::service inherits docker {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $docker::manage_docker_service)
  {
    if($docker::manage_service)
    {
      service { $docker::params::service_name:
        ensure => $docker::service_ensure,
        enable => $docker::service_enable,
      }
    }
  }
}
