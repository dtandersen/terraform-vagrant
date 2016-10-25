# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ogarcia/archlinux-x64"
  config.vm.box_version = "2016.10.01"
  config.vm.hostname = "terraform"
  config.vbguest.auto_update = false

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "Terraform"
    vb.memory = 512
    vb.cpus = 1
  end

  config.vm.provision "shell", env: {"TERRAFORM_VERSION" => "0.7.7"}, inline: <<-SHELL
    pacman --noconfirm -Syu
    pacman --noconfirm -S unzip wget git go virtualbox-guest-utils-nox virtualbox-guest-modules-arch
    wget -nv https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
	mkdir /opt/terraform
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /opt/terraform/bin
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

	# compile vultr provider
	mkdir -p terraform-provider-vultr/src/github.com/rgl/terraform-provider-vultr
	cd terraform-provider-vultr
	git clone -b master --single-branch https://github.com/rgl/terraform-provider-vultr src/github.com/rgl/terraform-provider-vultr
	export GOPATH=$PWD
	export PATH=$PWD/bin:$PATH
	hash -r # reset bash path
	go get github.com/hashicorp/terraform
	go get github.com/JamesClonk/vultr
	cd src/github.com/rgl/terraform-provider-vultr
	go build
	go test
	cp terraform-provider-vultr* /opt/terraform/bin/

	# clean up perms
	chmod 755 /opt/terraform/
	
	# setup environment
	echo "export PATH=/opt/terraform/bin:/vagrant/terraform:$PATH" >> /home/vagrant/.bashrc
	echo "alias tf=/vagrant/tf.sh" >> /home/vagrant/.bashrc
	echo "source ~/.credentials.sh" >> /home/vagrant/.bashrc
	cp /vagrant/.credentials-base.sh /home/vagrant/.credentials.sh
	chown vagrant:vagrant /home/vagrant/.credentials.sh
  SHELL
end
