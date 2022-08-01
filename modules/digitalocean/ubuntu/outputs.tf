
output "ip" {
  value       = digitalocean_droplet.ubuntu.ipv4_address
  description = "IP of created instance"
}

output "name" {
  value       = var.name
  description = "Name for droplets"
}

output "ssh_user" {
  value       = "root"
  description = "SSH username"
}

output "ssh_privkey" {
  value       = var.ssh_privkey
  description = "SSH private key location"
}
