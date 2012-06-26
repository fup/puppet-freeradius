class freeradius::mysql (
  $ensure       = 'present',
  $package_name = $freeradius::params::mysql_packages
) inherits freeradius::params {

  package { 'freeradius-mysql-support':
    ensure  => $ensure,
    name    => $package_name,
    require => Class['freeradius'],
  }
}
