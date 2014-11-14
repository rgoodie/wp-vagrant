
Vagrant.configure("2") do |config|
    config.vm.box = "Trusty64"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    
    config.vm.network :private_network, ip: "192.168.33.10"
    config.vm.network "forwarded_port", guest: 80, host: 8765


    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--name", "WP"]
    end

    config.vm.synced_folder "www", "/var/www", create: true #type: "nfs"
    #,:mount_options => ["dmode=777","fmode=666"]
    config.vm.provision :shell, :path => "bootstrap.sh"
    
    
end
