variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces new resources to be created."
  nullable    = false
  type        = string
  default     = "Australia East"
}

variable "random_pet_suffix" {
  description = "Set to true to generate random pet name suffix."
  type        = bool
  default     = false
}

variable "random_pet_length" {
  description = "The length (in words) of the pet name."
  type        = number
  default     = 1
}

variable "rg_name" {
  description = "(Required) The name of the resource group in which to create the subnets. Changing this forces new resources to be created."
  nullable    = false
  default     = "rg-bayu-network"
}

variable "vwan_type" {
  description = "(Required) Azure Virtual WAN SKU."
  type        = string
  default     = "Standard"
}

variable "vwan_name" {
  description = "(Required) Azure Virtual WAN name."
  type        = string
  default     = "vwan-bayu-ae"
}

variable "vwan_disable_vpn_encryption" {
  description = "Set to true to disable Azure Virtual WAN VPN Encryption."
  type        = bool
  default     = false
}

variable "vwan_allow_branch_to_branch_traffic" {
  description = "Set to true to alow branch to branch traffic via Azure Virtual WAN."
  type        = bool
  default     = true
}

variable "office365_local_breakout_category" {
  description = "Microsoft Office 365 local breakout category."
  type        = string
  default     = "None"
}

variable "vwan_hub_name" {
  description = "Azure Virtual WAN Hub name."
  type        = string
  default     = "securehub-bayu-ae"
}

variable "firewall_pip_name" {
  description = "Azure Firewall public IP name."
  type        = string
  default     = "pip-azfw-securehub-ae"
}

variable "firewall_pip_allocation_method" {
  description = "Azure Firewall public IP allocation method."
  type        = string
  default     = "Static"
}

variable "firewall_pip_sku" {
  description = "Azure Firewall public IP SKU."
  type        = string
  default     = "Standard"
}

variable "firewall_name" {
  description = "Azure Firewall name."
  type        = string
  default     = "fw-securehub-ae"
}

variable "firewall_sku_name" {
  description = "Azure Firewall SKU name."
  type        = string
  default     = "AZFW_Hub"
}

variable "firewall_sku_tier" {
  description = "Azure Firewall SKU tier"
  type        = string
  default     = "Premium"
}

variable "firewall_dns_proxy" {
  description = "Set to true to enable DNS Proxy on Azure Firewall."
  type        = bool
  default     = true
}

variable "firewall_policy_name" {
  description = "Azure Firewall policy name."
  type        = string
  default     = "policy-azfw-securehub-ae"
}

# threat intel needs to be off for AZFW_Hub SKU https://github.com/hashicorp/terraform-provider-azurerm/issues/12623
variable "firewall_threat_intelligence_mode" {
  description = "Azure Firewall Threat Intelligence mode."
  type        = string
  default     = "Off"
}

variable "vwan_hub_cidr" {
  description = "VWAN Virtual Hub CIDR"
  type        = string
  default     = "10.100.0.0/23"
}

variable "create_default_route" {
  description = "Set to true to create default route Azure Firewall."
  type        = bool
  default     = true
}

variable "create_rfc1918_routes" {
  description = "Set to true to create RFC 1918 routes Azure Firewall."
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "(Optional) A mapping of tags to assign to the virtual network."
  type        = map(string)
  default     = {}
}