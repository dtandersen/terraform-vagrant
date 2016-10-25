# What is Terraform?

> [Terraform](https://www.terraform.io/) provides a common configuration to launch infrastructure — from physical and virtual servers to email and DNS providers. Once launched, Terraform safely and efficiently changes infrastructure as the configuration is evolved.

# How to use this VM?

Run ```vagrant up``` and then, if new guest utils were installed, ```vagrant reload```. Then ```git clone``` a Terraform configuration. The Terraform command line utilities are on the PATH.

The development machine is based on Arch Linux.

# Credentials

Add credentials to /home/vagrant/.credentials.sh to load them automatically.

    export DIGITALOCEAN_TOKEN=
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    export VULTR_API_KEY=

# Providers

rgl's [Terraform provider for Vultr](https://github.com/rgl/terraform-provider-vultr) is included.
