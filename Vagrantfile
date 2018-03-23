# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 80, host: 8080
  

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
  
     # Customize the amount of memory on the VM:
     vb.memory = "1024"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.	
  config.vm.provision "shell", inline: <<-SHELL
  
  	apt-get purge -y mysql-server mariadb-server
  	
  	debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
	apt-get update
	apt-get install -y mysql-server mysql-client
        apt-get update
    
        apt-get install -y apache2 tree curl 
        apt-get install -y php-cli php php-mysql php-mdb2-driver-mysql
        apt-get install -y expect
 
	echo removing old wp-cli
	rm /usr/local/bin/wp
	rm -rf /home/vagrant/bin/

	echo making wp-cli and bin folder
	mkdir /home/vagrant/bin
	cd /home/vagrant/bin
	curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  
	chmod +x /home/vagrant/bin/wp-cli.phar
	chown vagrant:vagrant /home/vagrant/bin/wp-cli.phar
	ln -s /home/vagrant/bin/wp-cli.phar /usr/local/bin/wp
	
	echo file permissions
	chown vagrant:www-data /var/www -R
	
	echo wordpress database 
	mysql -u root -proot -e "create database wp;"
	mysql -u root -proot -e "grant all on wp.* to 'wp'@'localhost' identified by 'wp';"
	
	echo wordpress / throw away / not secure! 
	cd /var/www/html
	wp core download --allow-root
	wp core config --dbname=wp --dbuser=wp --dbpass=wp --allow-root
	wp core install --url=http://http://192.168.33.10/ --title="Insecure Blog" --admin_user=wp --admin_password=wp --admin_email=fake@example.com --allow-root
	rm index.html
	
	chown vagrant:www-data /var/www -R
	
	
	

  SHELL
  
  config.vm.provision "shell", inline: "pwd"
end
