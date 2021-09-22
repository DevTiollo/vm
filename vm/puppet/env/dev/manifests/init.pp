Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin", "/usr/local/sbin", "~/.composer/vendor/bin/" ] }

class { 'apache2::install': }
class { 'basic::install': }
class { 'binddns::install': }
class { 'composer::install': }
class { 'docker::install': }
class { 'git::install': }
class { 'letsencrypt::install': }
class { 'locales::install': }
class { 'memcached::install': }
class { 'mysql::install': }
class { 'node::install': }
class { 'php7::install': }
# class { 'postgresql::install': }
class { 'ntp::install': }
class { 'unzip::install': }
