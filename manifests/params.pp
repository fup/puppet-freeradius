class freeradius::params {
  case $::operatingsystem {
    debian: {
      $base_dir = '/etc/freeradius'
      $packages = ['freeradius', 'freeradius-common', 'freeradius-utils',
                   'libfreeradius2']
      $mysql_packages = ['freeradius-mysql']
    }
  }
}
