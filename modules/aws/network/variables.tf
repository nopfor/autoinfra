
variable "name" {
  description = "Name for network resources (appended with random ID)"
  type        = string
  default     = "autoinfra"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}
