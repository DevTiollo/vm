# VM:
Virtual Machine - Vagrant, Puppet on Debian 11 (bullseye64), PHP 7.4, MySql, Postgres, Memcached, Docker


## Dependency:
* Virtualbox: https://www.virtualbox.org/wiki/Downloads
* Vagrant: https://www.vagrantup.com/downloads


## Setup:
Open for editing the File: vagrantfile and change the top header content.
Settings options: Vhost Domains, IP, Memory, CPU's, Project Name (if running multiple)
Pay attention that if while naming your domains as .localhost or .local, you can get into issues since these names are reserver on MacOS.
Also the folder ~/work is crucial if you are running Antivirus software. Folders named as such will be avoided by the scanning process.


## Startup the VM:
* $ mkdir ~/work
* $ cd ~/work
* *  &#35; If work Folder is not empty, clone repository and move content into ~/work
* $ git clone https://github.com/tiollo-eu/vm.git . # clone project into ~/work/ folder
* $ cd ~/work/vm
* $ vagrant plugin install vagrant-hostsupdater
* $ vagrant plugin install vagrant-vbguest
* $ vagrant up --provision-with shell
* $ vagrant reload --provision
* $ vagrant reload --provision
* $ vagrant vbguest
  
After that, you should be able to navigate to: http://mydomain.vhost/ and check the phpinfo() output.


## Virtual Machine Content:
* Apache 2.4 (cgi/fpm)
* PHP 7.4 with: fpm, xdebug, apcu, opcache, memcached, pdo (mysql & pgsql), imagemagick
* Composer
* MySQL
* Memcached
* Docker
* NodeJs, NVM
* Unzip
   
Further Postgres is also available, if you wish to install, enable it, uncomment the class within vm/puppet/env/dev/manifests/init.pp (remove #)
  
NodeJS Version: While installing the VM, nvm is installed but not available, since the provisioning is running via root user. Since nvm is running under user vagrant expecting the export into .bashrc of the NVM variable for this user, the terminal has to be updated. All this happens at first login into the VM. After that, NVM is available and the following commands can be executed:
* $ nvm ls-remote
* $ nvm install v14.17.6
* $ nvm use default v14.17.6


## Troubleshooting:
* Your sources are not visible in the VM. If the Folder $ ls -la ~/www of vagrant is not reflecting your main ~/work/www this means that NFS is not running correctly. This can happen on Windows machines. Please attempt to find a solution for this. Any improvement suggestion for the mentioned OS is welcome.
* If after provisioning and navigating to your host URL, instead of phpinfo() the Apache default (/var/www/index.html) is displayed, this means that apache is not processing your FQDN virtual host. Run $ vagrant reload --provision
