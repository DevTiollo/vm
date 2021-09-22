# Install PHP

class php7::install {
  package { [
    'imagemagick',
    'mcrypt',
    'libruby',
    'php',
    'php-apcu',
    'php-bcmath',
    'php-cli',
    'php-common',
    'php-curl',
    'php-fpm',
    'php-gd',
    'php-imagick',
    'php-imap',
    'php-intl',
    'php-json',
    'libpcre3',
    'php-mysql',
    'php-mbstring',
    'php-memcached',
    'php-opcache',
    'php-pear',
    'php-pspell',
    'php-pgsql',
    'php-sqlite3',
    'php-tidy',
    'php-xdebug',
    'php-xml',
    'php-xmlrpc',
    'php-xsl',
    'php-zip',
  ]:
    ensure => installed,
    notify => File['/etc/php/7.4/fpm/php.ini']
  }
  
  file { '/etc/php/7.4/fpm/php.ini' :
    force   => true,
    source  => 'puppet:///modules/php7/php.ini',
    require => [Package['php', 'php-xdebug']],
    notify  => File['/etc/php/7.4/fpm/conf.d/20-xdebug.ini']
  }

  file { '/etc/php/7.4/fpm/conf.d/20-xdebug.ini' :
    force   => true,
    source  => 'puppet:///modules/php7/xdebug.ini',
    require => [Package['php', 'php-xdebug']],
    notify  => [Exec['reload apache2']]
  }
}
