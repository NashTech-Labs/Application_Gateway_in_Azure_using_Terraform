resource "azurerm_user_assigned_identity" "app-gw" {
  name                = local.user_assigned_identity
  resource_group_name = azurerm_resource_group.app-gw-rg.name
  location            = azurerm_resource_group.app-gw-rg.location
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name_VV}-public-ip"
  resource_group_name = azurerm_resource_group.app-gw-rg.name
  location            = azurerm_resource_group.app-gw-rg.location
  allocation_method   = var.allocation_method_VV
  sku                 = var.sku_public_ip_VV
  domain_name_label   = var.domain_name_label_VV
}

resource "azurerm_resource_group" "app-gw-rg" {
  name     = "${var.name_VV}-rg"
  location = var.location_VV
}

resource "azurerm_application_gateway" "agw" {
  name                = var.name_VV
  resource_group_name = azurerm_resource_group.app-gw-rg.name
  location            = azurerm_resource_group.app-gw-rg.location

  backend_address_pool {
    name         = local.default_backend_pool_name
    ip_addresses = local.default_backend_pool_ip_addresses
    fqdns        = local.default_backend_pool_fqdns
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_pools_VV

    content {
      name         = backend_address_pool.key
      ip_addresses = backend_address_pool.value.ip_addresses
      fqdns        = backend_address_pool.value.fqdns
    }
  }

  dynamic "probe" {
    for_each = var.health_probes_VV

    content {
      name                                      = probe.key
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      protocol                                  = probe.value.protocol
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      host                                      = probe.value.host
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings_VV

    content {
      name                                = backend_http_settings.key
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      host_name                           = backend_http_settings.value.host_name
      path                                = backend_http_settings.value.override_backend_path
      probe_name                          = backend_http_settings.value.probe_name
    }
  }

  frontend_ip_configuration {
    name                            = local.frontend_public_ip_configuration_name
    public_ip_address_id            = azurerm_public_ip.public_ip.id
    private_link_configuration_name = var.private_link_frontend_ip_name_VV == local.frontend_public_ip_configuration_name ? local.private_link_configuration_name : null
  }

  frontend_ip_configuration {
    name                            = local.frontend_private_ip_configuration_name
    subnet_id                       = data.azurerm_subnet.subnet.id
    private_ip_address_allocation   = local.private_ip_address_allocation
    private_ip_address              = local.ip_addresses
    private_link_configuration_name = var.private_link_frontend_ip_name_VV == local.frontend_private_ip_configuration_name ? local.private_link_configuration_name : null
  }

  dynamic "frontend_port" {
    for_each = [80, 443]

    content {
      name = "Http_${frontend_port.value}"
      port = frontend_port.value
    }
  }

  gateway_ip_configuration {
    name      = "${var.name_VV}-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.subnet.id
  }

  firewall_policy_id = data.azurerm_web_application_firewall_policy.waf.id

  ssl_profile {
    name = "${var.name_VV}-ssl-profile"
    ssl_policy {
      min_protocol_version = local.min_protocol_version
      policy_type          = local.policy_type
      policy_name          = local.ssl_policy_name
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app-gw.id]
  }

  dynamic "http_listener" {
    for_each = var.http_listeners_VV

    content {
      name                           = http_listener.key
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_names                     = http_listener.value.host_names
      ssl_certificate_name           = local.ssl_certificate_name
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules_VV
    content {
      name                       = request_routing_rule.key
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name != "" ? request_routing_rule.value.backend_address_pool_name : local.default_backend_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      url_path_map_name          = request_routing_rule.value.rule_type == "PathBasedRouting" ? request_routing_rule.value.url_path_map_name : null
      priority                   = request_routing_rule.value.priority
    }
  }

  sku {
    name     = var.sku_name_VV
    tier     = var.sku_tier_VV
    capacity = var.sku_capacity_VV
  }

  dynamic "url_path_map" {
    for_each = var.url_path_maps_VV
    content {
      name                               = url_path_map.key
      default_backend_address_pool_name  = local.default_backend_pool_name
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name
      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                       = path_rule.value.name
          paths                      = path_rule.value.paths
          backend_address_pool_name  = path_rule.value.backend_pool_name != null ? path_rule.value.backend_pool_name : local.default_backend_pool_name
          backend_http_settings_name = path_rule.value.backend_http_settings_name
        }
      }
    }
  }

  dynamic "private_link_configuration" {
    for_each = local.add_private_link_configuration ? ["this"] : []
    content {
      name = "${var.name_VV}-private-link"
      ip_configuration {
        name                          = "${var.name_VV}-private-link-ip-config"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = data.azurerm_subnet.private_link_configuration_subnet[0].id
        primary                       = true
      }
    }
  }

  depends_on = [
    azurerm_user_assigned_identity.app-gw
  ]
}