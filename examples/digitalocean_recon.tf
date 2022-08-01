
# digitalocean_recon: create a medium droplet with OSINT/Reconnaissance tools installed

# Create an DigitalOcean droplet running Ubuntu
module "do_server" {
  source = "./modules/digitalocean/ubuntu"

  # Droplet size
  size = "s-4vcpu-8gb"

  # Recon
  playbook  = "ansible/playbooks/recon.yml"
}

output "server_ip" {
  value = module.do_server.ip
  description = "Output IP address for server"
}
