
# Random ID to assign to module
resource "random_id" "main" {
  byte_length = 8
}

# Create resource group for deployments
resource "azurerm_resource_group" "main" {
  name     = "${var.name}-${random_id.main.hex}"
  location = var.location
}
