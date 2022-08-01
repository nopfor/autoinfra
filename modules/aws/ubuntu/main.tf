
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

# key pair for instance
resource "aws_key_pair" "ubuntu" {
  key_name   = "${var.name}-ubuntu_key-${random_id.main.hex}"
  public_key = file(var.ssh_pubkey)
}

# Create security group for inbound SSH
resource "aws_security_group" "ssh_ingress" {
  name        = "${var.name}-ssh_ingress-${random_id.main.hex}"
  description = "SSH inbound"

  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    ipv6_cidr_blocks = ["::/0"]
  }
}

# create instance
resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  count         = var.instance_count
  instance_type = var.instance_type
  key_name      = aws_key_pair.ubuntu.key_name

  subnet_id     = var.subnet_id

  vpc_security_group_ids = concat(tolist([aws_security_group.ssh_ingress.id]), var.security_groups)

  tags = {
    Name  = "${var.name}-ubuntu_${count.index + 1}-${random_id.main.hex}"
    Group = "${var.name}-ubuntu_cluster-${random_id.main.hex}"
  }

  # Update packages and install python (required for Ansible)
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Python installed"]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.ssh_privkey)
    }
  }

  # Execute Ansible playbook
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key '${var.ssh_privkey}' --extra-vars='${var.playbook_extra_vars}' '${var.playbook}'"
  }

  depends_on = [
    aws_key_pair.ubuntu,
    aws_security_group.ssh_ingress
  ]
}
