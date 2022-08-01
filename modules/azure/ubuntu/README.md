
# Ubuntu Server

Ubuntu server in Azure.

Requires a resource group and network.

## Usage

Basic usage:

```hcl
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

# Create an ubuntu VM
module "azure_ubuntu" {
  source = "./modules/azure/ubuntu"

  resource_group_name     = module.resource_group.name
  resource_group_location = module.resource_group.location

  subnet_id = module.azure_network.subnet_id
}
```

## Documentation

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Virtual machine computer name | `string` | `"ubuntu"` | no |
| <a name="input_image_ubuntu_offer"></a> [image\_ubuntu\_offer](#input\_image\_ubuntu\_offer) | Azure VM image offer (`az vm image list -p Canonical -o table --all`) | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_image_ubuntu_sku"></a> [image\_ubuntu\_sku](#input\_image\_ubuntu\_sku) | Azure VM image SKU (`az vm image list -p Canonical -f 0001-com-ubuntu-server-jammy -o table --all`) | `string` | `"22_04-lts"` | no |
| <a name="input_name"></a> [name](#input\_name) | Virtual machine name | `string` | `"autoinfra"` | no |
| <a name="input_playbook"></a> [playbook](#input\_playbook) | Ansible playbook path | `string` | `"ansible/playbooks/ubuntu.yml"` | no |
| <a name="input_playbook_extra_vars"></a> [playbook\_extra\_vars](#input\_playbook\_extra\_vars) | Extra variables for Ansible playbook (no single quotes) | `string` | `"{}"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Resource group location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Virtual machine size (https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/) | `string` | `"Standard_B1ls"` | no |
| <a name="input_ssh_privkey"></a> [ssh\_privkey](#input\_ssh\_privkey) | SSH private key path | `string` | `"./data/ssh/autoinfra_rsa"` | no |
| <a name="input_ssh_pubkey"></a> [ssh\_pubkey](#input\_ssh\_pubkey) | SSH public key path | `string` | `"./data/ssh/autoinfra_rsa.pub"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Internal subnet ID | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Admin username | `string` | `"ubuntu"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | Public FQDN |
| <a name="output_ip"></a> [ip](#output\_ip) | Public IP address |
| <a name="output_name"></a> [name](#output\_name) | Virtual machine name |
| <a name="output_ssh_privkey"></a> [ssh\_privkey](#output\_ssh\_privkey) | SSH private key location |
| <a name="output_ssh_user"></a> [ssh\_user](#output\_ssh\_user) | SSH username |
<!-- END_TF_DOCS -->