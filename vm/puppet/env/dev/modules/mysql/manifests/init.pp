class mysql::install {
  package { [
    'whois',
    'mariadb-client',
    'mariadb-server',
  ]:
    ensure => installed,
    notify => Exec['Persist Password'],
  }

  $user = 'root'
  $password = generate('/bin/bash', '-c', "date +%s | sha256sum | base64 | head -c 32 | tr -d '\n'")
  notice( "MySql Password: $password" )

  exec { 'Persist Password':
    refreshonly => true,
    user        => "root",
    unless      => ["test ! -f /root/.my.cnf", "mysql -u${user} -p$password -e status"],
    command     => "echo \"[client]\npassword=${password}\" > /root/.my.cnf",
    notify      => [Exec['Root Password'], Exec['See Password']],
    require     => [Service["mysql"]],
  }

  exec { 'See Password':
    refreshonly => true,
    user        => "root",
    unless      => ["test ! -f /root/.my.cnf", "mysql -u${user} -p${password} -e status"],
    command     => "echo ${password} - MySql Password",
    notify      => Exec['Root Password'],
    require     => [Service["mysql"], Exec['Persist Password']],
  }

  exec { "Root Password":
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    unless    => ["mysql -u${user} -p$password -e status"],
    command   => "mysql -u${user} -p${password} -e \"use mysql; update user set password=PASSWORD(\"${password}\") where User='root'; FLUSH PRIVILEGES;\"",
    user      => $user,
    logoutput => "on_failure",
    require   => Service['mysql'],
  }

  file {'/etc/mysql/my.cnf':
    force     => true,
    source    => 'puppet:///modules/mysql/etc/mysql/my.cnf',
    #require => Service["mysql"],
  }

  service { 'mysql':
    name    => 'mysql',
    ensure  => 'running',
    enable  => true,
    require => [Package['mariadb-client'], Package['mariadb-server'], File['/etc/mysql/my.cnf']],
  }

}