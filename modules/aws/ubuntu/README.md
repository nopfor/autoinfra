
# Ubuntu Server

Ubuntu server in AWS.

Requires an AWS network.

## Usage

Basic usage:

```hcl
# Create an AWS VPC
module "aws_network" {
  source = "./modules/aws/network"
}

# Create an AWS EC2 instance running Ubuntu
module "aws_server" {
  source = "./modules/aws/ubuntu"

  vpc_id    = module.aws_network.vpc_id
  subnet_id = module.aws_network.subnet_id
}

# Output IP addresses for servers
output "server_ips" {
  value = join("\n", module.aws_server.ips)
}
```

### Security Groups

By default, inbound traffic is restricted to SSH from 0.0.0.0/0.

The following example shows how to explicitly define the allowed CIDR blocks for SSH traffic and add an additional security group:

```hcl
# Create an AWS VPC
module "aws_network" {
  source = "./modules/aws/network"
}

# Create security group to allow web traffic inbound on port 80 and 443
resource "aws_security_group" "web" {
  name        = "autoinfra-web"
  description = "Allow web traffic inbound on port 80 and 443"

  vpc_id = module.aws_network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an AWS EC2 instance running Ubuntu
module "aws_server" {
  source = "./modules/aws/ubuntu"

  vpc_id    = module.aws_network.vpc_id
  subnet_id = module.aws_network.subnet_id

  ssh_cidr_blocks = ["0.0.0.0/0"]
  security_groups = tolist([aws_security_group.web.id])]
}

# Output IP addresses for servers
output "server_ips" {
  value = join("\n", module.aws_server.ips)
}
```

## Documentation

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of instances to launch | `number` | `1` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to launch | `string` | `"t2.nano"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for instances and group | `string` | `"autoinfra"` | no |
| <a name="input_playbook"></a> [playbook](#input\_playbook) | Ansible playbook path | `string` | `"ansible/playbooks/ubuntu.yml"` | no |
| <a name="input_playbook_extra_vars"></a> [playbook\_extra\_vars](#input\_playbook\_extra\_vars) | Extra variables for Ansible playbook (no single quotes) | `string` | `"{}"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups to add to instances | `list(string)` | `[]` | no |
| <a name="input_ssh_cidr_blocks"></a> [ssh\_cidr\_blocks](#input\_ssh\_cidr\_blocks) | CIDR blocks applied to security group which allows SSH inbound | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ssh_privkey"></a> [ssh\_privkey](#input\_ssh\_privkey) | SSH private key path | `string` | `"./data/ssh/autoinfra"` | no |
| <a name="input_ssh_pubkey"></a> [ssh\_pubkey](#input\_ssh\_pubkey) | SSH public key path | `string` | `"./data/ssh/autoinfra.pub"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to create instance in | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to create instance in | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_ips"></a> [ips](#output\_ips) | IPs of created instances |
| <a name="output_name"></a> [name](#output\_name) | Name for instances and group |
| <a name="output_ssh_privkey"></a> [ssh\_privkey](#output\_ssh\_privkey) | SSH private key location |
| <a name="output_ssh_user"></a> [ssh\_user](#output\_ssh\_user) | SSH username |
<!-- END_TF_DOCS -->