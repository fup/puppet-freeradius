class freeradius::radiusclient::config {
  include concat::setup

  file { $freeradius::params::radius['radiusclient_dir']:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }


  file { "${freeradius::params::radius['radiusclient_dir']}/port-id-map":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat { "${freeradius::params::radius['radiusclient_dir']}/servers":
    owner => 'root',
    group => 'root',
    mode  => '0640',
  }
}
