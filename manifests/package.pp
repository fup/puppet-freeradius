class freeradius::package(
  $server,
  $client
) {

  if $server == true {
    package { $freeradius::params::radius['packages']:
      ensure => present,
    }
  }
  if $client == true {
    package { $freeradius::params::radius['client_packages']:
      ensure => present,
    }
  }
}
