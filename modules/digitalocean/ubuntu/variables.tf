
variable "image" {
  description = "DigitalOcean image name or slug"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "name" {
  description = "Name for droplets"
  type        = string
  default     = "ubuntu"
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "nyc1"
}

variable "size" {
  description = "Droplet size (https://slugs.do-api.dev/)"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ipv6" {
  description = "Enable IPv6"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the droplet"
  type        = list(string)
  default     = []
}

variable "ssh_privkey" {
  description = "SSH private key path"
  type        = string
  default     = "./data/ssh/autoinfra"
}

variable "ssh_pubkey" {
  description = "SSH public key path"
  type        = string
  default     = "./data/ssh/autoinfra.pub"
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
