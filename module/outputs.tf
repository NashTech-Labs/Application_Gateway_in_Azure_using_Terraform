output "application-gateway-id" {
  description = "application-gateway id"
  value       = azurerm_application_gateway.agw.id
}

output "private_ip_address" {
  description = "Private Ip Address of application gateway fromend ip configuration"
  value       = [for i in data.azurerm_application_gateway.application_gateway_data.frontend_ip_configuration : i.private_ip_address if i.private_ip_address != ""]
}

output "frontend_private_ip_configuration_name" {
  value = azurerm_application_gateway.agw.frontend_ip_configuration[1].name
}