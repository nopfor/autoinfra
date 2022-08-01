
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

resource "digitalocean_ssh_key" "ubuntu" {
  name       = "${var.name}-ubuntu_key-${random_id.main.hex}"
  public_key = file(var.ssh_pubkey)
}

resource "digitalocean_droplet" "ubuntu" {
  image  = var.image
  name   = "${var.name}-${random_id.main.hex}"
  region = var.region
  size   = var.size
  
  ssh_keys = [digitalocean_ssh_key.ubuntu.fingerprint]

  tags = var.tags
  ipv6 = var.ipv6

  # Update packages and install python (required for Ansible)
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Python installed"]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = "root"
      private_key = file(var.ssh_privkey)
    }
  }

  # Execute Ansible playbook
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key '${var.ssh_privkey}' --extra-vars='${var.playbook_extra_vars}' '${var.playbook}'"
  }
}
