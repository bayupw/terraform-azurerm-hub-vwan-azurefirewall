locals {
  firewall_pip_name    = var.random_pet_suffix ? "${var.firewall_pip_name}-${random_pet.this[0].id}" : var.firewall_pip_name
  firewall_name        = var.random_pet_suffix ? "${var.firewall_name}-${random_pet.this[0].id}" : var.firewall_name
  firewall_policy_name = var.random_pet_suffix ? "${var.firewall_policy_name}-${random_pet.this[0].id}" : var.firewall_policy_name
}

resource "azurerm_public_ip" "this" {
  name                = local.firewall_pip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.firewall_pip_allocation_method
  sku                 = var.firewall_pip_sku
}

resource "azurerm_firewall" "this" {
  name                = local.firewall_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier
  firewall_policy_id  = azurerm_firewall_policy.this.id
  # threat_intel_mode = "Off"

  virtual_hub {
    virtual_hub_id  = azurerm_virtual_hub.this.id
    public_ip_count = 1
  }

  # Require explicit dependency to allow terraform destroy to work
  depends_on = [azurerm_firewall_policy.this]
}

resource "azurerm_firewall_policy" "this" {
  name                     = local.firewall_policy_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  sku                      = var.firewall_sku_tier
  threat_intelligence_mode = var.firewall_threat_intelligence_mode # threat intel needs to be off for AZFW_Hub SKU https://github.com/hashicorp/terraform-provider-azurerm/issues/12623

  # Enabling DNS Proxy on Azure Firewall is required for FQDN-based Network Rules
  dns {
    proxy_enabled = var.firewall_dns_proxy
  }

}