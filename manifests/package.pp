class freeradius::package {
  package { $freeradius::params::packages:
    ensure => present,
  }
}
