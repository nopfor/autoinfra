
# autoinfra: automated infrastructure

Ansible playbooks and Terraform modules for automatically deploying infrastructure for penetration testing, red team exercises, and bug bounties.

## Quick Start

The quick start assumes the following (follow the steps in [Setup](#setup), below, for complete instructions):

- Terraform and Ansible are installed
- The operator has existing AWS access keys

The following commands will create (and then destroy) a `t2.medium` EC2 instance with [OSINT/Reconnaissance tools](ansible/roles/recon) installed:

```sh
git clone https://github.com/nopfor/autoinfra
cd autoinfra

ssh-keygen -a 256 -t ed25519 -f data/ssh/autoinfra

cp examples/aws_recon.tf main.tf

export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_KEY"
export AWS_DEFAULT_REGION="YOUR_AWS_REGION"

terraform init
terraform apply

terraform destroy
```

## What's Included

### Ansible Roles/Playbooks

Ansible roles automate software component installation. These can be run on any existing infrastructure.

- [Recon](ansible/roles/recon): Automatically installs OSINT/Reconnaissance tools 
- [OpenVPN](ansible/roles/openvpn-server): Create an OpenVPN server and automatically generate client configurations
- [Squid Proxy](ansible/roles/squid-proxy): Create a squid proxy on a non-standard port
- [Socat Redirector](ansible/roles/redirector-socat): TCP redirector using `socat`
- [Ubuntu](ansible/roles/ubuntu): Standard tasks to be run on newly-deployed Ubuntu machines

### Terraform Modules

Terraform modules assist with infrastructure orchestration/provisioning. These will create infrastructure in the cloud.

- AWS
	- [Network](modules/aws/network): All network components needed to run an EC2 instance
	- [Ubuntu Server](modules/aws/ubuntu): Ubuntu server EC2 instance configured to run Ansible playbooks
- DigitalOcean
  - [Ubuntu Server](modules/digitalocean/ubuntu): Ubuntu server in DigitalOcean
- Azure
  - [Resource Group](modules/azure/resource_group): Creates and Azure Resource Group
  - [Network](modules/azure/network): Set up network and subnet for Azure virtual machines
  - [Ubuntu Server](modules/azure/ubuntu): Ubuntu server in Azure

### Examples

Several examples are included. Copy these to `main.tf` and run terraform to get started.

- [AWS Recon](examples/aws_recon.tf): Create a `t2.medium` EC2 instance with OSINT/Reconnaissance tools installed
- [AWS OpenVPN Server](examples/aws_openvpn.tf): Create an OpenVPN server in AWS and generate 2 client configs
- [AWS Squid Proxy](examples/aws_squid_proxy.tf): Create an EC2 instance with a Squid proxy on a non-standard port (note: by default this is accessible to the entire internet)
- [DigitalOcean Recon](examples/aws_recon.tf): Create a medium droplet with OSINT/Reconnaissance tools installed
- [Azure Recon](examples/aws_recon.tf): Create a medium Ubuntu server VM in Azure with OSINT/Reconnaissance tools installed

## Setup

### Terraform and Ansible

The following commands will install Terraform and Ansible on a Debian or Ubuntu machine:

```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform ansible
```

See the [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installation guides for more information.

**Note:** Terraform 1.20 is required for Azure running an Ubuntu 22.04 instance due to https://github.com/hashicorp/terraform/issues/30134t

### SSH Keys

An existing SSH key pair is required to provision new instances. By default, Terraform will look for these at `data/ssh/autoinfra{,.pub}` (and `data/ssh/autoinfra_rsa{,.pub}` for providers, such as Azure, that only support RSA keypairs).

To create new keypairs, run the following (note: password-protected SSH keys are not currently supported):

```sh
ssh-keygen -a 256 -t ed25519 -f data/ssh/autoinfra
ssh-keygen -t rsa -b 4096 -f data/ssh/autoinfra_rsa
```

### Cloud Access Keys or Tokens

autoinfra requires at least one cloud provider to be configured to operate. Instructions for getting access keys or tokens from supported providers are below:

- [AWS](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys)
- [Microsoft Azure](https://docs.microsoft.com/en-us/azure/media-services/latest/setup-azure-subscription-how-to?tabs=portal)
- [DigitalOcean](https://hostlaunch.io/docs/how-to-get-a-digitalocean-api-key/)

Terraform can use these if set in envrionment variables:

```sh
# AWS
export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_KEY"
export AWS_DEFAULT_REGION="YOUR_AWS_REGION"

# DO
export DIGITALOCEAN_TOKEN="YOUR_DO_TOKEN"

# Azure
export ARM_SUBSCRIPTION_ID="YOUR_AZURE_SUBSCRIPTION_ID"
```

Alternatively, the following can be added to a Terraform file (ex: `main.tf` or `providers.tf`):

```sh
provider "aws" {
  access_key = "YOUR_AWS_ACCESS_KEY"
  secret_key = "YOUR_AWS_SECRET_KEY"
  region = "YOUR_AWS_REGION"
}

provider "digitalocean" {
  token = "YOUR_DO_TOKEN"
}

provider "azurerm" {
  features {}
  subscription_id = "YOUR_AZURE_SUBSCRIPTION_ID"
}
```
