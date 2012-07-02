define freeradius::radiusclient::server(
  $host,
  $secret
) {
  include freeradius

  concat::fragment { $name:
    target  => "${freeradius::params::radius['radiusclient_dir']}/servers",
    content => "${host} ${secret}\n",
    order   => '01',
  }
}
