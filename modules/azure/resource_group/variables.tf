
variable "name" {
  description = "Name for resource group (appended with random ID)"
  type        = string
  default     = "autoinfra"
}

variable "location" {
  description = "Resource group location"
  type        = string
  default     = "West US 2"
}