# Enable MySQL Support for FreeRADIUS
class freeradius::mysql (
  $ensure                      = 'present',
  $package_name                = $freeradius::params::radius['mysql_packages'],
  $port                        = undef,
  $type                        = 'mysql',
  $server,
  $login,
  $password,
  $radius_db                   = $freeradius::params::db['mysql']['radius_db'],
  $acct_table1                 = $freeradius::params::db['common']['acct_table1'],
  $acct_table2                 = $freeradius::params::db['common']['acct_table2'],
  $postauth_table              = $freeradius::params::db['common']['postauth_table'],
  $authcheck_table             = $freeradius::params::db['common']['authcheck_table'],
  $authreply_table             = $freeradius::params::db['common']['authreply_table'],
  $groupcheck_table            = $freeradius::params::db['common']['groupcheck_table'],
  $groupreply_table            = $freeradius::params::db['common']['groupreply_table'],
  $usergroup_table             = $freeradius::params::db['common']['usergroup_table'],
  $read_groups                 = $freeradius::params::db['common']['read_groups'],
  $deletestalesessions         = $freeradius::params::db['common']['deletestalesessions'],
  $sqltrace                    = $freeradius::params::db['common']['sqltrace'],
  $sqltracefile                = $freeradius::params::db['common']['sqltracefile'],
  $num_sql_socks               = $freeradius::params::db['common']['num_sql_socks'],
  $connect_failure_retry_delay = $freeradius::params::db['common']['connect_failure_retry_delay'],
  $lifetime                    = $freeradius::params::db['common']['lifetime'],
  $max_queries                 = $freeradius::params::db['common']['max_queries'],
  $readclients                 = $freeradius::params::db['common']['readclients'],
  $nas_table                   = $freeradius::params::db['common']['nas_table']
) inherits freeradius::params {

  package { 'freeradius-mysql-support':
    ensure  => $ensure,
    name    => $package_name,
  } ->  #package before file
  file { "${freeradius::params::radius['base_dir']}/sql.conf":
    ensure  => file,
    owner   => 'root',
    group   => $freeradius::params::radius['gid'],
    mode    => '0640',
    content => template('freeradius/common/sql.conf.erb'),
  } -> # file before support file, in freeradius::config
       # Anchor to the virtual file in freeradius::config for
       # proper ordering.
    File <| tag == 'freeradius_module_sql' |> {
  }
}
