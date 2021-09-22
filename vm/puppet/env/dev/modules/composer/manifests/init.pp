class composer::install {

  package { "curl":
    ensure => installed,
    notify => Exec['composer'],
  }

  exec { 'composer':
    cwd         => '/tmp',
    #environment => ['COMPOSER_HOME=/services'],
    #command     => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer ; chmod 0755 /usr/local/bin/composer && composer self-update',
    command     => 'curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer',
    require     => [Package['curl','php', 'git']],
    logoutput   => 'on_failure',
    unless      => 'ls /usr/local/bin/composer'
  }
}