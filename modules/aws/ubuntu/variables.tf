
variable "vpc_id" {
  description = "VPC ID to create instance in"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to create instance in"
  type        = string
}

variable "name" {
  description = "Name for instances and group"
  type        = string
  default     = "autoinfra"
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks applied to security group which allows SSH inbound"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "Instance type to launch"
  type        = string
  default     = "t2.nano"
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "security_groups" {
  description = "Security groups to add to instances"
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
