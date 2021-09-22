# Install postgresql
class postgresql::install {
  package { [
    'postgresql',
    'pgloader'
  ]:
    ensure => installed,
  }
}