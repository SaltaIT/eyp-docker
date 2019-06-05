define docker::image(
                      $github_url   = undef,
                      $image_origin = 'github',
                      $imagename    = $name,
                      $srcdir       = '/usr/local/src',
                    ) {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "eyp-docker image ${imagename} ${srcdir}":
    command => "mkdir -p ${srcdir}",
    creates => $srcdir,
  }

  exec { "eyp-docker image ${imagename} git":
    command => 'which git',
    unless  => 'which git',
  }

  schedule { 'eyp-docker image daily schedule':
    period => 'daily',
    repeat => 1,
  }

  case $image_origin
  {
    'github':
    {
      if($github_url==undef)
      {
        fail('github url not provided for a github image')
      }

      if ($github_url =~ /\/([^\/]+)\/?$/)
      {
        $github_reponame = $1
      }
      else
      {
        fail('malformed github url')
      }

      exec { "git clone ${imagename}":
        command => "git clone ${github_url}",
        cwd     => $srcdir,
        creates => "${srcdir}/${github_reponame}",
        require => Exec[ [ "eyp-docker image ${imagename} git", "eyp-docker image ${imagename} ${srcdir}" ] ],
      }

      #scheduled
      exec { "git pull ${imagename}":
        command  => 'git pull',
        unless   => 'git pull',
        cwd      => "${srcdir}/${github_reponame}",
        schedule => 'eyp-docker image daily schedule',
        require  => Exec["git clone ${imagename}"],
      }
    }
    default:
    {
      fail('unsupported image source')
    }
  }


}
