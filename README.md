# Terraform Azure Virtual WAN Secure Hub with Azure Firewall

Terraform module to deploy Azure Virtual WAN Secure Hub with Azure Firewall

## Prerequisites
- Authentication to Azure, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

## Sample usage

```hcl
module "securehub" {
  source  = "bayupw/hub-vwan-azurefirewall/azurerm"
  version = "1.0.0"

  random_pet_suffix = true
  location          = "Australia East"

  vwan_type     = "Standard"
  vwan_name     = "vwan-bayu-ae"
  vwan_hub_name = "securehub-bayu-ae"
  vwan_hub_cidr = "10.100.0.0/23"

  firewall_name               = "fw-securehub-ae"
  firewall_sku_name           = "AZFW_Hub"
  firewall_sku_tier           = "Premium"
  firewall_dns_proxy          = true
  firewall_policy_name        = "policy-default-ae"
}

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-azurerm-hub-vwan-azurefirewall/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-azurerm-hub-vwan-azurefirewall/tree/master/LICENSE) for full details.