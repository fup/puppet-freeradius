class freeradius::config inherits freeradius::params {
  $osfamily_lower = inline_template("<%= @osfamily.downcase %>")

  File {
    owner => 'root',
    group => $freeradius::params::radius['gid'],
    mode  => '0640',
  }

  file { "${freeradius::params::radius['base_dir']}/radiusd.conf":
    ensure  => file,
    content => template("freeradius/${osfamily_lower}/radiusd.conf.erb"),
  }
  file { $freeradius::params::radius['listen_dir']:
    ensure  => directory,
    purge   => 'true',
    recurse => 'true',
  }
  file { $freeradius::params::radius['vhost_dir']:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { $freeradius::params::radius['client_dir']:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${freeradius::params::radius['base_dir']}/clients.conf":
    ensure  => file,
    content => "\$INCLUDE clients/\n"
  }
  @file { "${freeradius::params::radius['base_dir']}/modules/enable_sql":
    ensure  => file,
    content => "\$INCLUDE ${freeradius::params::radius['base_dir']}/sql.conf",
    tag     => "freeradius_module_sql",
  }
}
