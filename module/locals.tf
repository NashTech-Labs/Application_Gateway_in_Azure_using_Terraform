locals {
  ssl_policy_name                        = "AppGwSslPolicy20170401S"
  min_protocol_version                   = "TLSv1_2"
  policy_type                            = "Predefined"
  private_ip_address_allocation          = "Static"
  ip_addresses                           = cidrhost(data.azurerm_subnet.subnet.address_prefixes[0], 5)
  default_backend_pool_name              = "${var.name_VV}-backend-pool"
  default_backend_pool_ip_addresses      = coalesce(var.default_backend_pool_VV.ip_addresses, var.backend_address_pool_ip_addresses_VV)
  default_backend_pool_fqdns             = coalesce(var.default_backend_pool_VV.fqdns, var.backend_address_pool_fqdns_VV)
  frontend_public_ip_configuration_name  = "${var.name_VV}-frontend-public"
  frontend_private_ip_configuration_name = "${var.name_VV}-frontend-private"
  ssl_certificate_name                   = "${var.name_VV}-cert"
  user_assigned_identity                 = "${var.name_VV}-app-gw-uai"
  add_private_link_configuration         = var.private_link_config_subnet_VV != ""
  private_link_configuration_name        = "${var.name_VV}-private-link"

}
