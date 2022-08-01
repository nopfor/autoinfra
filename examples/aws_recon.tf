
# aws_recon: create a t2.medium EC2 instance with OSINT/Reconnaissance tools installed

# Create an AWS VPC
module "aws_network" {
  source = "./modules/aws/network"
}

# Create an AWS EC2 instance running Ubuntu
module "aws_server" {
  source = "./modules/aws/ubuntu"

  vpc_id    = module.aws_network.vpc_id
  subnet_id = module.aws_network.subnet_id

  # Instance size
  instance_type = "t2.medium"

  # Recon
  playbook  = "ansible/playbooks/recon.yml"
}

output "server_ips" {
  value = join("\n", module.aws_server.ips)
  description = "Output IP addresses for servers"
}
