class docker::audit (
                    ) inherits docker::params {
  if(defined(Class['::audit']))
  {
    # eyp-audit
    audit::customfile { 'docker.rules':
      content => template("${module_name}/audit_rules.erb"),
    }
  }
}
