# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 8989

  config.vm.network "forwarded_port", guest: 80,  host: 8989, auto_correct: true
  config.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true

  #Remeber to change the host port to avoid clashes with different boxes
  config.vm.network "forwarded_port", guest: 22, host: 2224, id: "ssh"
  
  #Same here, increment ip and change it in etc/hosts on host machine
  config.vm.network "private_network", ip: "192.168.33.13"
  config.vm.network "public_network"
  # This can be added if there is a connection issue
  # config.vm.network "public_network", :bridge => 'en1: Wi-Fi (AirPort)'

  # php uses www-data user, so we need to assign permissions for those folders
  # npm and node use vagrant user
  # this can be either sorted by booting from second option and installing all with first
  # or as it was already done in provision - the vagrant user has been added to www-data group
  # so we can use the normal one
  #  config.vm.synced_folder "www/", "/var/www/html", owner: "www-data", group: "www-data" #for composer
  config.vm.synced_folder "www/", "/var/www/html" #for npm

  # config.vm.provider "virtualbox" do |vb|
  #   #### Add this line while vagrant hangs on ssh auth 
  #   # vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  config.vm.provision "shell", path: "provision.sh"  
  #  use this while there is an ssh error while vagrant up/halt  
  #  config.ssh.keep_alive = true
end
