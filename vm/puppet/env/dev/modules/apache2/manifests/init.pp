# Install Apache

class apache2::install {
  package { [
    'apache2',
    'apache2-doc',
    'apache2-utils',
    'libapache2-mod-fcgid'
  ]:
    ensure => installed,
    notify  => Exec['a2dismod'],
  }

  exec { 'a2dismod':
    command     => '/usr/sbin/a2dismod php7.4 mpm_prefork',
    require     => [Package['apache2', 'php']],
    logoutput   => 'on_failure',
    user        => 'root',
    notify      => [Exec['a2enconf']],
  }

  exec { 'a2enconf':
    command     => '/usr/sbin/a2enconf php7.4-fpm',
    logoutput   => 'on_failure',
    user        => 'root',
    require     => [Package['apache2', 'php', 'php-fpm', 'libapache2-mod-fcgid']],
    notify      => [Exec['a2enmod']]
  }

  exec { 'a2enmod':
    command     => '/usr/sbin/a2enmod mpm_event negotiation proxy proxy_fcgi vhost_alias setenvif actions alias suexec rewrite ssl actions include cgi dav_fs dav auth_digest headers',
    logoutput   => 'on_failure',
    user        => 'root',
    require     => [Package['apache2']],
    notify      => [File['/etc/apache2/sites-available/default.conf']]
  }

  file { '/etc/apache2/sites-available/default.conf':
    source      => 'puppet:///modules/apache2/etc/apache2/sites-available/default.conf',
    require     => [Package['apache2'], Exec['a2enmod'], Exec['a2dismod']],
    notify    => File['/etc/apache2/sites-enabled/default.conf'],
  }

  file { '/etc/apache2/sites-enabled/default.conf':
    ensure    => link,
    target    => '/etc/apache2/sites-available/default.conf',
    require   => [File['/etc/apache2/sites-available/default.conf']],
    notify    => File['/etc/apache2/sites-enabled/000-default.conf'],
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure    => absent,
    force     => true,
    recurse   => true,
    require   => [Package['apache2'], Exec['a2enmod'], Exec['a2dismod']],
    notify    => Exec['reload apache2'],
  }

  exec { 'reload apache2':
    command     => 'service apache2 reload',
    unless      => 'apache2ctl configtest',
    refreshonly => true,
    user        => 'root',
  }
}

