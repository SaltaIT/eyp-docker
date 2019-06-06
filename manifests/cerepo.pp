class docker::cerepo() inherits docker::params {
  yumrepo { 'docker':
    ensure  => 'present',
    descr   => 'Docker Community Edition repository for CentOS',
    baseurl => 'https://download.docker.com/linux/centos/7/x86_64/stable',
    enabled => true,
  }
}
