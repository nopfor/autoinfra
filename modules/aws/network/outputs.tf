
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "VPC CIDR"
}

output "subnet_id" {
  value       = aws_subnet.main.id
  description = "Subnet ID"
}

output "subnet_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "Subnet CIDR"
}
