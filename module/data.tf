data "azurerm_web_application_firewall_policy" "waf" {
  name                = var.waf_policy_name_VV
  resource_group_name = "${var.waf_policy_name_VV}-rg"
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_VV
  resource_group_name = var.vnet_resource_group_VV
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_VV
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_subnet" "private_link_configuration_subnet" {
  count                = local.add_private_link_configuration ? 1 : 0
  name                 = var.private_link_config_subnet_VV
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

# data "azurerm_key_vault" "central-kv" {
#   name                = var.key_vault_name
#   resource_group_name = "key-vault-${var.key_vault_name}-rg"
# }

# data "azurerm_key_vault_certificate" "central-kv-cert" {
#   name         = var.key_vault_cert_name
#   key_vault_id = data.azurerm_key_vault.central-kv.id
# }



# data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
#   count               = var.log_analytics_workspace != null ? 1 : 0
#   name                = var.log_analytics_workspace
#   resource_group_name = var.log_analytics_workspace_rg
# }

data "azurerm_application_gateway" "application_gateway_data" {
  name                = azurerm_application_gateway.agw.name
  resource_group_name = azurerm_application_gateway.agw.resource_group_name
}
