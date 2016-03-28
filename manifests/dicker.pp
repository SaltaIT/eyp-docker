#
class docker::dicker($srcdir = '/usr/local/src') inherits docker::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  exec { 'wget dicker':
    command => "bash -c 'wget $(wget https://api.github.com/repos/jordiprats/dicker/releases/latest -O - 2>/dev/null | grep tarball_url | awk '\"'\"'{ print \$2 }'\"'\"' | cut -f2 -d\\\") -O ${srcdir}/dicker.tgz'",
    creates => "${srcdir}/dicker.tgz",
    notify  => Exec['dicker package extract'],
  }

  exec { 'dicker package extract':
    command     => "tar xf ${srcdir}/dicker.tgz --wildcards --no-anchored '*${docker::params::package_type}' --strip-components=1 --transform='s/[a-z0-9._\\-]*\\.rpm/dicker.${docker::params::package_type}/i' -C ${srcdir}",
    refreshonly => true,
    creates     => "${srcdir}/dicker.${docker::params::package_type}",
    notify      => Exec['dicker package install'],
  }

  case $docker::params::package_type
  {
    'rpm':
    {
      exec { 'dicker package install':
        command => "rpm -Uvh ${srcdir}/dicker.${docker::params::package_type}",
        refreshonly => true,
      }
    }
    default: { fail('unsupported package type for dicker') }
  }
}
