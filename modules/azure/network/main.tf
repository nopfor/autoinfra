
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

# Create virtual network
resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-${random_id.main.hex}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  address_space = [var.network_cidr_block]
}

# Create subnet
resource "azurerm_subnet" "internal" {
  name                 = "${var.name}-internal-${random_id.main.hex}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [var.subnet_cidr_block]

  depends_on = [azurerm_virtual_network.main]
}
