output "azurerm_resource_group" {
  description = "The created Resource Group as an object with all of it's attributes."
  value       = azurerm_resource_group.this
}

output "azurerm_virtual_wan" {
  description = "The created Azure Virtual WAN as an object with all of it's attributes."
  value       = azurerm_virtual_wan.this
}

output "azurerm_virtual_hub" {
  description = "The created Azure Virtual WAN Virtual Hub as an object with all of it's attributes."
  value       = azurerm_virtual_hub.this
}

output "azurerm_firewall" {
  description = "The created Azure Firewall as an object with all of it's attributes."
  value       = azurerm_firewall.this
}

output "azurerm_firewall_policy" {
  description = "The created Azure Firewall Policy as an object with all of it's attributes."
  value       = azurerm_firewall_policy.this
}