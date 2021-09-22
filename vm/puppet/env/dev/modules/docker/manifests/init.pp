# Install docker
class docker::install {
  package { [
    'apt-transport-https',
    'ca-certificates',
    'software-properties-common',
    'gnupg2'
  ]:
    ensure => installed,
    notify => Exec['docker-ce']
  }

  exec { 'docker-ce':
    cwd         => '/tmp',
    command     => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4528B6CD9E61EF26 && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && apt update && apt install -y docker-ce',
    require     => [Package['apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'gnupg2']],
    logoutput   => 'on_failure',
    notify => Exec['docker-compose']
  }

  exec { 'docker-compose':
    cwd         => '/tmp',
    command     => 'curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose',
    require     => [Package['curl']],
    logoutput   => 'on_failure'
  }
}
