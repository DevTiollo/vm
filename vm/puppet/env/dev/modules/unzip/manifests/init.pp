# Install UnZip

class unzip::install {
  package { "unzip":
    ensure => installed,
  }
}