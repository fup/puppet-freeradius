class freeradius::service inherits freeradius::params {
  service { $freeradius::params::radius['service_name']:
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}
