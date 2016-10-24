# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ogarcia/archlinux-x64"
  config.vm.box_version = "2016.07.01"
  config.vm.hostname = "terraform"

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "Terraform"
    vb.memory = 512
    vb.cpus = 1
  end

  config.vm.provision "shell", env: {"TERRAFORM_VERSION" => "0.7.1"}, inline: <<-SHELL
    pacman --noconfirm -Syu
    pacman --noconfirm -S unzip wget git
    wget -nv https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /opt/terraform
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	echo "export PATH=/opt/terraform:/vagrant/terraform:$PATH" >> /home/vagrant/.bashrc
	echo "alias tf=/vagrant/tf.sh" >> /home/vagrant/.bashrc
	echo "source ~/.credentials.sh" >> /home/vagrant/.bashrc
	chmod 755 /opt/terraform/
  SHELL
end
