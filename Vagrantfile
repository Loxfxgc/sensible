# Vagrantfile
Vagrant.configure("2") do |config|
  # Use generic Ubuntu box that works on both Intel and ARM
  config.vm.box = "generic/ubuntu2004"

  # Web Server 1
  config.vm.define "web1" do |web1|
    web1.vm.hostname = "web1"
    web1.vm.network "private_network", ip: "192.168.56.10"
    web1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  end

  # Web Server 2
  config.vm.define "web2" do |web2|
    web2.vm.hostname = "web2"
    web2.vm.network "private_network", ip: "192.168.56.11"
    web2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
  end

  # Database Server
  config.vm.define "db1" do |db1|
    db1.vm.hostname = "db1"
    db1.vm.network "private_network", ip: "192.168.56.20"
    db1.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end
end
