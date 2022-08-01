
# azure_recon: create a medium Ubuntu server VM in Azure with OSINT/Reconnaissance tools installed

# Create a resource group
module "resource_group" {
  source = "./modules/azure/resource_group"
}

# Create network
module "azure_network" {
  source = "./modules/azure/network"

  resource_group_name     = module.resource_group.name
  resource_group_location = module.resource_group.location
}

# Create an Ubuntu VM
module "azure_server" {
  source = "./modules/azure/ubuntu"

  resource_group_name     = module.resource_group.name
  resource_group_location = module.resource_group.location
  subnet_id               = module.azure_network.subnet_id

  # VM size
  size = "Standard_B2s"

  # Recon
  playbook  = "ansible/playbooks/recon.yml"
}

output "server_fqdn" {
  value = module.azure_server.fqdn
  description = "Output FQDN for server"
}

output "server_ip" {
  value = module.azure_server.ip
  description = "Output IP address for server"
}

