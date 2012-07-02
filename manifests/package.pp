class freeradius::package {
  package { $freeradius::params::radius['packages']:
    ensure => present,
  }
}
