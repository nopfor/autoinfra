
# Ubuntu Server

Ubuntu server in DigitalOcean.

## Usage

Basic usage:

```hcl
module "do_server" {
  source = "./modules/digitalocean/ubuntu"
}
```

## Documentation

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | DigitalOcean image name or slug | `string` | `"ubuntu-22-04-x64"` | no |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | Enable IPv6 | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for droplets | `string` | `"ubuntu"` | no |
| <a name="input_playbook"></a> [playbook](#input\_playbook) | Ansible playbook path | `string` | `"ansible/playbooks/ubuntu.yml"` | no |
| <a name="input_playbook_extra_vars"></a> [playbook\_extra\_vars](#input\_playbook\_extra\_vars) | Extra variables for Ansible playbook (no single quotes) | `string` | `"{}"` | no |
| <a name="input_region"></a> [region](#input\_region) | DigitalOcean region | `string` | `"nyc1"` | no |
| <a name="input_size"></a> [size](#input\_size) | Droplet size (https://slugs.do-api.dev/) | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_ssh_privkey"></a> [ssh\_privkey](#input\_ssh\_privkey) | SSH private key path | `string` | `"./data/ssh/autoinfra"` | no |
| <a name="input_ssh_pubkey"></a> [ssh\_pubkey](#input\_ssh\_pubkey) | SSH public key path | `string` | `"./data/ssh/autoinfra.pub"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the droplet | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip"></a> [ip](#output\_ip) | IP of created instance |
| <a name="output_name"></a> [name](#output\_name) | Name for droplets |
| <a name="output_ssh_privkey"></a> [ssh\_privkey](#output\_ssh\_privkey) | SSH private key location |
| <a name="output_ssh_user"></a> [ssh\_user](#output\_ssh\_user) | SSH username |
<!-- END_TF_DOCS -->