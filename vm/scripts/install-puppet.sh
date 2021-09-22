#!/bin/bash

echo '============= Updating ============='
apt-get update
apt-get update --fix-missing
apt-get upgrade
apt-get install -y build-essential linux-headers-amd64 linux-image-amd64 python3-pip
apt-get install -f
echo '============= /Updating ============='

echo '============= PUPPET ============='
cd /tmp
wget http://apt.puppetlabs.com/puppet-release-bullseye.deb
dpkg -i puppet-release-bullseye.deb
apt-get update
apt-get -y install puppet-agent puppet-common
echo "PATH=/opt/puppetlabs/bin:$PATH" >> /etc/bash.bashrc
echo "export PATH" >> /etc/bash.bashrc
export PATH=/opt/puppetlabs/bin:$PATH
echo '============= /PUPPET ============='
exit