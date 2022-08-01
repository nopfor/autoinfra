
# aws_openvpn: create an OpenVPN server in AWS and generate 2 client configs

# Create an AWS VPC
module "aws_network" {
  source = "./modules/aws/network"
}

# Create security group to allow OpenVPN on 443/tcp
resource "aws_security_group" "openvpn" {
  name        = "autoinfra-openvpn"
  description = "OpenVPN on TCP port 443"

  vpc_id = module.aws_network.vpc_id
  
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

  security_groups = tolist([aws_security_group.openvpn.id])

  # OpenVPN
  playbook  = "ansible/playbooks/openvpn-server.yml"
  playbook_extra_vars = "{'vpn_clients': ['client1', 'client2']}"
}

output "server_ips" {
  value = join("\n", module.aws_server.ips)
  description = "Output IP addresses for servers"
}
