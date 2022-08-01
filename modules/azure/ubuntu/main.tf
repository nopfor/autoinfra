
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

# Create a public IPv4 address
resource "azurerm_public_ip" "main" {
    name                         = "${var.name}-public_ip-${random_id.main.hex}"
    resource_group_name          = var.resource_group_name
    location                     = var.resource_group_location
    allocation_method            = "Static"
}

# Create an internal NIC
resource "azurerm_network_interface" "main" {
  name                = "${var.name}-internal-${random_id.main.hex}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = "${var.name}-internal-${random_id.main.hex}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  depends_on = [azurerm_public_ip.main]
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.name}-${random_id.main.hex}"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  size                  = var.size
  admin_username        = var.username
  computer_name         = var.hostname
  network_interface_ids = [azurerm_network_interface.main.id]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_pubkey)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = var.image_ubuntu_offer
    sku       = var.image_ubuntu_sku
    version   = "latest"
  }

  depends_on = [
    azurerm_public_ip.main,
    azurerm_network_interface.main
  ]
}

data "azurerm_public_ip" "main" {
  name                = azurerm_public_ip.main.name
  resource_group_name = azurerm_linux_virtual_machine.main.resource_group_name
}

resource "null_resource" "execute" {
  connection {
    type        = "ssh"
    agent       = false
    host        = data.azurerm_public_ip.main.ip_address
    user        = var.username
    private_key = file(var.ssh_privkey)
    timeout     = "1m"
  }
  
  # Update packages and install python (required for Ansible)
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Python installed"]
  }

  # Execute Ansible playbook
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${var.username}' -i '${data.azurerm_public_ip.main.ip_address},' --private-key '${var.ssh_privkey}' --extra-vars='${var.playbook_extra_vars}' '${var.playbook}'"
  }

  depends_on = [azurerm_linux_virtual_machine.main]
}
