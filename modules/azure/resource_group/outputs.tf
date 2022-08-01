
output "id" {
  value       = azurerm_resource_group.main.id
  description = "Resource group id"
}

output "name" {
  value       = azurerm_resource_group.main.name
  description = "Resource group name"
}

output "location" {
  value       = azurerm_resource_group.main.location
  description = "Resource group location"
}
