
# Azure Network

Set up network and subnet for Azure virtual machines.

Requires a Resource Group.

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
```

## Documentation

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Network/subnet name (appended with random ID) | `string` | `"autoinfra"` | no |
| <a name="input_network_cidr_block"></a> [network\_cidr\_block](#input\_network\_cidr\_block) | Virtual network CIDR block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Resource group location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_subnet_cidr_block"></a> [subnet\_cidr\_block](#input\_subnet\_cidr\_block) | Subnet CIDR block | `string` | `"10.0.0.0/24"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | Network id |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Subnet id |
<!-- END_TF_DOCS -->