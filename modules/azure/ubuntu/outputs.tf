
output "ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "Public IP address"
}

output "fqdn" {
  value       = azurerm_public_ip.main.fqdn
  description = "Public FQDN"
}

output "name" {
  value       = var.name
  description = "Virtual machine name"
}

output "ssh_user" {
  value       = var.username
  description = "SSH username"
}

output "ssh_privkey" {
  value       = var.ssh_privkey
  description = "SSH private key location"
}

