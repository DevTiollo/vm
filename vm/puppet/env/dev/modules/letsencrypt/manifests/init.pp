class letsencrypt::install {
  package { [
    'letsencrypt'
  ]:
    ensure => installed,
  }
}