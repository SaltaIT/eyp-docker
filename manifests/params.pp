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
          $repo_docker_ce = false
          $package_name='docker-io'
        }
        /^7.*$/:
        {
          $repo_docker_ce = true
          $package_name='docker'
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
