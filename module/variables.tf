######################
# Required Variables #
######################

variable "name_VV" {
  type = string
  description = "Common Name for all"
}

variable "location_VV" {
  type = string
  description = "Location of the Resources"
}

variable "vnet_VV" {
  type = string
  description = "Name of AKS VNet"
}

variable "vnet_resource_group_VV" {
  type = string
  description = "Name of the AKS Vnet resource group"
}

variable "subnet_VV" {
  type = string
  description = "Name of AKS Subnet"
}

variable "waf_policy_name_VV" {
  type = string
  description = "WAF Policy"
}

variable "backend_http_settings_VV" {
  type = map(object({
    cookie_based_affinity               = optional(string, "Disabled")
    port                                = number
    protocol                            = string
    request_timeout                     = optional(number, 60)
    pick_host_name_from_backend_address = optional(bool, false)
    override_backend_path               = optional(string)
    probe_name                          = optional(string)
    host_name                           = optional(string)
  }))
  description = "Backend Http Settings"
}


variable "http_listeners_VV" {
  type = map(object({
    frontend_port_name             = string
    frontend_ip_configuration_name = string
    protocol                       = string
    host_names                     = optional(list(string))
  }))
  description = "Http Listeners"
}

variable "request_routing_rules_VV" {
  type = map(object({
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = optional(string, "")
    backend_http_settings_name = string
    url_path_map_name          = optional(string)
    priority                   = number
  }))
  description = "Requesting Routing Rules"
}

######################
# Optional Variables #
######################

variable "allocation_method_VV" {
  type = "string"
  default = "Static"
  description = "Allocation Method"
}

variable "sku_public_ip_VV" {
  type = "string"
  default = "Standard"
  description = "SKU Public Ip"
}

variable "backend_address_pool_ip_addresses_VV" {
  type        = list(string)
  description = "This variable will be removed in future versions."
  default     = null
}

variable "backend_address_pool_fqdns_VV" {
  type        = list(string)
  description = "This variable will be removed in future versions.."
  default     = null
}

variable "default_backend_pool_VV" {
  type = object({
    ip_addresses = optional(list(string), [])
    fqdns        = optional(list(string), [])
  })
  description = "Default backend pool, traffic will be sent to this backend target unless matches a path rule."
  default     = {}
}

variable "backend_pools_VV" {
  type = map(object({
    ip_addresses = optional(list(string), [])
    fqdns        = optional(list(string), [])
  }))
  description = "Additional backend pools"
  default     = {}
}

variable "health_probes_VV" {
  type = map(object({
    path                                      = string
    interval                                  = optional(number, 30)
    timeout                                   = optional(number, 30)
    unhealthy_threshold                       = optional(number, 3)
    protocol                                  = optional(string, "Http")
    pick_host_name_from_backend_http_settings = optional(bool, true)
    host                                      = optional(string)
    match_status_code                         = optional(list(string), ["200-399", "401"])
  }))
  description = "Backend health probes"
  default     = {}
}

variable "sku_name_VV" {
  type    = string
  default = "WAF_v2"
  description = "SKU Name"
}

variable "sku_tier_VV" {
  type    = string
  default = "WAF_v2"
  description = "Type of SKU"
}

variable "sku_capacity_VV" {
  type    = number
  default = 1
  description = "SKU Capacity"
}

variable "url_path_maps_VV" {
  type = map(object({
    default_backend_http_settings_name = string
    path_rules = list(object({
      name                       = string
      paths                      = list(string)
      backend_http_settings_name = string
      backend_pool_name          = optional(string)
    }))
  }))
  default = {}
  description = "URI Path of Maps"
}

variable "private_link_config_subnet_VV" {
  description = "name of the subnet id for private link configuration"
  type        = string
  default     = ""
}

variable "private_link_frontend_ip_name_VV" {
  description = "frontend ip configuration name for private link configuration"
  type        = string
  default     = ""
}

variable "domain_name_label_VV" {
  description = "The domain name label for public IP. Leave it as null if not needed"
  type        = string
  default     = null
}
