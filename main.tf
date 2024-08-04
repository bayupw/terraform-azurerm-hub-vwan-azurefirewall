data "azurerm_subscription" "this" {}

locals {
  rg_name       = var.random_pet_suffix ? "${var.rg_name}-${random_pet.this[0].id}" : var.rg_name
  vwan_name     = var.random_pet_suffix ? "${var.vwan_name}-${random_pet.this[0].id}" : var.vwan_name
  vwan_hub_name = var.random_pet_suffix ? "${var.vwan_hub_name}-${random_pet.this[0].id}" : var.vwan_hub_name
}

resource "random_pet" "this" {
  count  = var.random_pet_suffix ? 1 : 0
  length = 1
}

resource "azurerm_resource_group" "this" {
  location = var.location
  name     = local.rg_name
}

resource "azurerm_virtual_wan" "this" {
  resource_group_name               = azurerm_resource_group.this.name
  location                          = azurerm_resource_group.this.location
  name                              = local.vwan_name
  type                              = var.vwan_type
  disable_vpn_encryption            = var.vwan_disable_vpn_encryption
  allow_branch_to_branch_traffic    = var.vwan_allow_branch_to_branch_traffic
  office365_local_breakout_category = var.office365_local_breakout_category
}

resource "azurerm_virtual_hub" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  name                = local.rg_name
  virtual_wan_id      = azurerm_virtual_wan.this.id
  address_prefix      = var.vwan_hub_cidr
}

resource "azurerm_virtual_hub_route_table_route" "default_to_firewall" {
  count  = var.create_default_route ? 1 : 0

  name              = "DefaultViaFirewall"
  destinations_type = "CIDR"
  destinations      = ["0.0.0.0/0"]
  next_hop_type     = "ResourceId"
  next_hop          = azurerm_firewall.this.id
  route_table_id    = azurerm_virtual_hub.this.default_route_table_id
}

resource "azurerm_virtual_hub_route_table_route" "rfc1918_to_firewall" {
  count  = var.create_rfc1918_routes ? 1 : 0

  name              = "RFC1918ViaFirewall"
  destinations_type = "CIDR"
  destinations      = ["10.0.0.0/8", "172.16.0.0/16", "192.168.0.0/16"]
  next_hop_type     = "ResourceId"
  next_hop          = azurerm_firewall.this.id
  route_table_id    = azurerm_virtual_hub.this.default_route_table_id
}