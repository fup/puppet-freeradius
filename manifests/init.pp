class freeradius(
  $server = false,
  $client = true
) inherits freeradius::params {
  include stdlib

  anchor { 'freeradius::begin': }
  -> class { 'freeradius::package':
    server => $server,
    client => $client,
  }
  -> anchor { 'freeradius::end': }

  # Only configure server elements if requested.
  if $server == true {
    class { 'freeradius::config':
      require => Class['freeradius::package'],
    }
    ~> class { 'freeradius::service':
      before => Anchor['freeradius::end'],
    }
  }

  if $client == true {
    class { 'freeradius::radiusclient::config':
      require => Class['freeradius::package'],
      before  => Anchor['freeradius::end'],
    }
  }
}
