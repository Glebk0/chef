# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "chef-server" do |cf|
    cf.vm.box = "ubuntu/xenial64"
    cf.vm.hostname = 'chef-server'
    cf.vm.network :private_network, ip: "192.168.2.10"
    cf.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 3024]
      v.customize ["modifyvm", :id, "--name","chef-server"]
    end
  end
  config.vm.define "mysql-node" do |db|
    db.vm.box = "bento/ubuntu-14.04"
    db.vm.hostname = 'db-server'
    db.vm.network :private_network, ip: "192.168.2.13"
    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 900]
      v.customize ["modifyvm", :id, "--name","db-server"]
    end
  end
  config.vm.define "app-node" do |app|
    app.vm.box = "sbeliakou/centos"
    app.vm.box_version = "7.5"
    app.vm.hostname = 'app-server'
    app.vm.network :private_network, ip: "192.168.2.12"
    app.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 900]
      v.customize ["modifyvm", :id, "--name","app-server"]
    end
  end
end