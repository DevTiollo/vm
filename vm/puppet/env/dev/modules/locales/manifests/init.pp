class locales::install {
  package { [
    'locales',
  ]:
    ensure => installed,
  }

  file { "/etc/locale.gen":
    source  => 'puppet:///modules/locales/locale.gen',
    owner   => "root",
    group   => "root",
    mode    => "0644",
    require => Package[locales],
  }

  exec { "locale-gen":
    command => 'locale-gen "en_US.UTF-8"',
    subscribe => File["/etc/locale.gen"],
    refreshonly => true,
    require => [ Package["locales"], File["/etc/locale.gen"] ],
    notify  => File['/etc/default/locale']
  }

  file { "/etc/default/locale":
    source    => 'puppet:///modules/locales/locale',
    require   => Package[locales],
    notify    => Exec['update-locale']
  }

  exec { "update-locale":
    command     => '/usr/sbin/update-locale',
    subscribe   => File["/etc/locale.gen"],
    require     => [ Package["locales"], File["/etc/locale.gen"] ],
    #notify     => File['/etc/default/locale']
  }
}
