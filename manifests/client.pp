define freeradius::client (
  $ipaddr                        = undef,
  $ipv6addr                      = undef,
  $secret,
  $netmask                       = $freeradius::params::client['netmask'],
  $nastype                       = $freeradius::params::client['nastype'],
  $require_message_authenticator = $freeradius::params::client['require_message_authenticator'],
  $login                         = undef,
  $password                      = undef,
  $virtual_server                = undef,
  $coa_server                    = undef
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if ($ipaddr != undef) and ($ipv6addr != undef) {
    fail("freeradius::client: Cannot define both IPv4/IPv6 Addresses (${name})")
  }

  file { "${freeradius::params::radius['client_dir']}/${name}.conf":
    ensure  => file,
    content => template('freeradius/common/client.conf.erb'),
  }
}
