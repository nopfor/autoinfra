
# aws_squid_proxy: create an EC2 instance with a Squid proxy on a non-standard port
#   (note: by default this is accessible to the entire internet)

# Set allowed networks for Squid proxy
# WARNING: This will allow inbound traffic to the proxy from anywhere
#   It is recommended to change this to the operator's network before deploying
variable "allow_networks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

# Set password for Squid proxy (default user: autoinfra)
variable "proxy_pass" {
  type = string
  default = "autoinfra"
}

# Create an AWS VPC
module "aws_network" {
  source = "./modules/aws/network"
}

# Create security group to allow Squid Proxy on 2831/tcp
resource "aws_security_group" "squid" {
  name        = "autoinfra-squidproxy"
  description = "Squid proxy on TCP port 2831"

  vpc_id = module.aws_network.vpc_id
  
  ingress {
    from_port   = 2831
    to_port     = 2831
    protocol    = "tcp"
    cidr_blocks = var.allow_networks
  }
}

# Create an AWS EC2 instance running Ubuntu
module "aws_server" {
  source = "./modules/aws/ubuntu"

  vpc_id    = module.aws_network.vpc_id
  subnet_id = module.aws_network.subnet_id

  security_groups = tolist([aws_security_group.squid.id])

  # Squid Proxy
  playbook  = "ansible/playbooks/squid-proxy.yml"
  playbook_extra_vars = "{'proxy_port': 2831, 'proxy_pass': '${var.proxy_pass}', allow_networks': ['${join("','", var.allow_networks)}']}"

}

output "server_ips" {
  value = join("\n", module.aws_server.ips)
  description = "Output IP addresses for servers"
}
