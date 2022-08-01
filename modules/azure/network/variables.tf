
variable "name" {
  description = "Network/subnet name (appended with random ID)"
  type        = string
  default     = "autoinfra"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "Resource group location"
  type        = string
}

variable "network_cidr_block" {
  description = "Virtual network CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}
