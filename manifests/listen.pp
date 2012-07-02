define freeradius::listen (
  $type        = 'auth',
  $listen_ip   = '*',
  $listen_ipv6 = undef,
  $port        = '0',
  $interface   = undef,
  $clients     = undef
) {

  file { "${freeradius::params::radius['listen_dir']}/${name}.conf":
    ensure  => file,
    owner   => 'root',
    group   => $freeradius::params::radius['gid'],
    mode    => '0640',
    content => template('freeradius/common/listen.conf.erb'),
  }
}
