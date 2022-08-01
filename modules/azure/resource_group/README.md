
# Resource Group

Creates and Azure Resource Group.

## Example

```hcl
module "resource_group" {
  source = "./modules/azure/resource_group"
}
```

## Documentation

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Resource group location | `string` | `"West US 2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for resource group (appended with random ID) | `string` | `"autoinfra"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Resource group id |
| <a name="output_location"></a> [location](#output\_location) | Resource group location |
| <a name="output_name"></a> [name](#output\_name) | Resource group name |
<!-- END_TF_DOCS -->