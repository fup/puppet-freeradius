class freeradius::radiusclient::config {
  include concat::setup

  file { $freeradius::params::radius['radiusclient_dir']:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  concat { "${freeradius::params::radius['radiusclient_dir']}/servers":
    owner => 'root',
    group => 'root',
    mode  => '0640',
  }
}
