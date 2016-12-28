class docker::swarm() inherits docker::params {

  #TODO: http://blog.vpetkov.net/2015/12/07/docker-swarm-tutorial-and-examples/
  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  exec { 'docker swarm':
    command => 'docker pull swarm',
    unless  => 'docker images | grep \'docker.io/swarm\'',
  }

  fail('not implemented')

}
