class docker::params {
  case $::osfamily
  {
    #docker_package
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          $docker_package='docker-io'
        }
        /^7.*$/:
        {
          $docker_package='docker'
        }
        default: { fail("Unsupported RHEL/CentOS version!")  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
