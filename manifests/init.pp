class freeradius inherits freeradius::params {
  include stdlib

  anchor { 'freeradius::begin': }
  -> class { 'freeradius::package': }
  -> class { 'freeradius::config': }
  ~> class { 'freeradius::service': }
  -> anchor { 'freeradius::end': }
}
