define docker::container() {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
}
