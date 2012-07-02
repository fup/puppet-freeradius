# Class: freeradius::params
#
# Description
#   This class holds default parameters used throughout this module.
#   All sections will be commented to detail their usage inside of this module.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
class freeradius::params {

  # Use this section to specifiy OS / Class specific options
  # that may/will differ on a per-(distro|OS)
  #
  # Mandatory Includes in each case:
  #  - $base_dir = (String) The base directory that is created by the package
  #                         manager.
  #  - $packages = (Array) The list of packages that are to be installed by
  #                        the package manager.
  #  - $radius   = (Hash) This has specifies OS specific
  case $::operatingsystem {
    debian,ubuntu: {
      $radius         = {
        uid              => 'freerad',
        gid              => 'freerad',
        base_dir         => '/etc/freeradius',
        listen_dir       => "/etc/freeradius/listen",
        vhost_dir        => '/etc/freeradius/sites-enabled',
        client_dir       => '/etc/freeradius/clients',
        radiusclient_dir => '/etc/radiusclient',
        packages         => ['freeradius'],
        client_packages  => ['libradius1'],
        mysql_packages   => ['freeradius-mysql'],
        service_name     => 'freeradius'
      }
    }
  }

  # Default settings for freeradius::listen
  $listen = {
    type        => 'auth',
    listen_ip   => '*',
    listen_ipv6 => undef,
    port        => '0',
    interface   => undef,
    clients     => undef
  }

  # Default settings for freeradius::client
  $client = {
    netmask                       => '32',
    nastype                       => 'other',
    require_message_authenticator => 'no',
  }

  # Default settings for freeraidus::vhost
  # FreeRADIUS Equivilent of vHosts (apache)
  $vhost = {
    authorize => {
      preprocess    => true,
      auth_log      => false,
      chap          => true,
      mschap        => true,
      digest        => true,
      wimax         => false,
      ipass         => false,
      suffix        => true,
      ntdomain      => false,
      eap           => {
        ok => 'return'
      },
      unix          => false,
      files         => true,
      sql           => false,
      smbpasswd     => false,
      ldap          => false,
      daily         => false,
      checkval      => false,
      expiration    => true,
      logintime     => true,
      pap           => true
    },
    authentication => {
      pap    => ['pap'],
      chap   => ['chap'],
      mschap => ['mschap'],
      digest => true,
      pam    => false,
      unix   => false,
      ldap   => false, # ['ldap'],
      eap    => true
    },
    preacct => {
      preprocess  => true,
      acct_unique => true,
      ipass       => false,
      suffix      => true,
      ntdomain    => false,
      files       => true
    },
    accounting => {
      detail              => true,
      daily               => false,
      unix                => true,
      radutmp             => true,
      sradutmp            => false,
      main_pool           => false,
      sql                 => false,
      ignore_zero_session => false,
      sql_log             => false,
      pgsql_voip          => false,
      exec                => true
    },
    session => {
      radutmp => true,
      sql     => false
    },
    postauth => {
      main_pool => false,
      reply_log => false,
      sql       => false,
      sql_log   => false,
      ldap      => false,
      exec      => true,
      wimax     => false,
      reject    => false
    },
    preproxy => {
      attr_rewrite  => false,
      files         => false,
      pre_proxy_log => false
    },
    postproxy => {
      post_proxy_log => false,
      attr_rewrite   => false,
      eap            => true
    }
  }


  # Default settings for the database add-ons.
  $db = {
    mysql => {
      radius_db => 'radius'
    },
    common => {
      acct_table1                 => 'radacct',
      acct_table2                 => 'radacct',
      postauth_table              => 'radpostauth',
      authcheck_table             => 'radcheck',
      authreply_table             => 'radreply',
      groupcheck_table            => 'radgroupcheck',
      groupreply_table            => 'radgroupreply',
      usergroup_table             => 'radusergroup',
      read_groups                 => undef,
      deletestalesessions         => 'yes',
      sqltrace                    => 'no',
      sqltracefile                => '${logdir}/sqltrace.sql',
      num_sql_socks               => '5',
      connect_failure_retry_delay => '60',
      lifetime                    => '0',
      max_queries                 => '0',
      readclients                 => undef,
      nas_table                   => 'nas'
    }
  }
}
