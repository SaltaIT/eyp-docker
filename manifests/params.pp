class docker::params {

  $service_name = 'docker'

  case $::osfamily
  {
    #docker_package
    'redhat' :
    {
      $package_type='rpm'
      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          $package_name='docker-io'
        }
        /^7.*$/:
        {
          $package_name='docker'
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
