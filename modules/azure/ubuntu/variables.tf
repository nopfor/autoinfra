
variable "name" {
  description = "Virtual machine name"
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

variable "subnet_id" {
  description = "Internal subnet ID"
  type        = string
}

variable "username" {
  description = "Admin username"
  type        = string
  default     = "ubuntu"
}

variable "hostname" {
  description = "Virtual machine computer name"
  type        = string
  default     = "ubuntu"
}

variable "size" {
  description = "Virtual machine size (https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/)"
  type        = string
  default     = "Standard_B1ls"
}

variable "image_ubuntu_offer" {
  description = "Azure VM image offer (`az vm image list -p Canonical -o table --all`)"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_ubuntu_sku" {
  description = "Azure VM image SKU (`az vm image list -p Canonical -f 0001-com-ubuntu-server-jammy -o table --all`)"
  type        = string
  default     = "22_04-lts"
}

variable "ssh_privkey" {
  description = "SSH private key path"
  type        = string
  default     = "./data/ssh/autoinfra_rsa"
}

variable "ssh_pubkey" {
  description = "SSH public key path"
  type        = string
  default     = "./data/ssh/autoinfra_rsa.pub"
}

variable "playbook" {
  description = "Ansible playbook path"
  type        = string
  default     = "ansible/playbooks/ubuntu.yml"
}

variable "playbook_extra_vars" {
  description = "Extra variables for Ansible playbook (no single quotes)"
  type        = string
  default     = "{}"
}
