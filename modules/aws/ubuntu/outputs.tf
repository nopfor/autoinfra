
output "ips" {
  value       = aws_instance.ubuntu.*.public_ip
  description = "IPs of created instances"
}

output "name" {
  value       = var.name
  description = "Name for instances and group"
}

output "ssh_user" {
  value       = "ubuntu"
  description = "SSH username"
}

output "ssh_privkey" {
  value       = var.ssh_privkey
  description = "SSH private key location"
}
