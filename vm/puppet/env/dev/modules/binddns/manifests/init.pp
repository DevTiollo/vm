class binddns::install {
  package { [
    'bind9',
    'dnsutils',
    'haveged'
  ]:
    ensure => installed,
  }
}