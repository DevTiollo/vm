# Install basic

class basic::install {
  package { [
    'wget',
    'mlocate',
    'net-tools'
  ]:
    ensure => installed,
  }
}
