class node::install {
  package { [
    'npm'
    ]:
    ensure => installed,
    notify  => Exec['nvm'],
  }

  exec { 'nvm':
    cwd         => '/home/vagrant/',
    environment => ['HOME=/home/vagrant/'],
    command     => 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash',
    user        => 'root',
    require     => [Package['wget', 'npm']],
    logoutput   => 'on_failure',
    notify      => File['/home/vagrant/.nvm']
  }

  file { '/home/vagrant/.nvm' :
    ensure      => directory,
    owner       => 'vagrant',
    group       => 'vagrant',
    recurse     => true,
    notify      => Exec['nvm_info']
  }

  exec { 'nvm_info':
    command     => 'echo -e "In order to set proper NodeJS version, run: \n$ nvm install v14.17.6"',
    require     => [File['/home/vagrant/.nvm']],
  }
}
