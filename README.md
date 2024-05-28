## Description

Here, In this template, we will create the application gateway and enable the traffic in Azure cloud using the terraform scripts. 


---

#### Pre-requisite

* AZ Account
* Azure CLI

---

### Steps:-
1. Login into AZ account using `az login` or `az login --tenant <TENANT-ID>`
2. Login into the Azure using the Service Principal the Service Principal like `az service principal -u <client-id> -p <client-password> -t <tenant-ID>`.

---
 
## Configuration

The following table lists the configurable parameters for the module with their default values.

| Parameters                           | Description                                                                                   | Default  | Type        | Required |
|--------------------------------------|-----------------------------------------------------------------------------------------------|----------|-------------|----------|
| name_VV                              | Common Name for all                                                                           |          | string      | Yes      |  
| location_VV                          | Location of the Resources                                                                     |          | string      | Yes      |  
| vnet_resource_group_VV               | Name of the AKS Vnet resource group                                                           |          | string      | Yes      |
| vnet_VV                              | Name of AKS VNet                                                                              |          | string      | Yes      |
| subnet_aks_VV                        | Name of AKS Subnet                                                                            |          | string      | Yes      |
| http_listeners_VV                    | Http Listeners                                                                                |          | map(object) | Yes      |
| request_routing_rules_VV             | Requesting Routing Rules                                                                      |          | map(object) | Yes      |
| waf_policy_name_VV                   | WAF Policy                                                                                    |          | string      | Yes      |
| backend_http_settings_VV             | Backend Http Settings                                                                         |          | string      | Yes      |
| allocation_method_VV                 | Allocation Method                                                                             | static   | string      | Yes      |
| sku_public_ip_VV                     | SKU Public Ip                                                                                 | standard | string      | Yes      |
| backend_address_pool_ip_addresses_VV | This variable will be removed in future versions.                                             |          | string      | Yes      |
| backend_address_pool_fqdns_VV        | This variable will be removed in future versions.                                             |          | string      | Yes      |
| default_backend_pool_VV              | Default backend pool, traffic will be sent to this backend target unless matches a path rule. |          | List(string | Yes      |
| backend_pools_VV                     | Additional backend pools                                                                      |          | Map(object) | Yes      |
| health_probes_VV                     | Backend health probes                                                                         |          | Map(object) | Yes      |
| sku_name_VV                          | SKU Name                                                                                      | WAF_v2   | string      | Yes      |
| sku_tier_VV                          | Type of SKU                                                                                   | WAF_v2   | string      | Yes      |
| sku_capacity_VV                      | SKU Capacity                                                                                  | 1        | number      | Yes      |
| url_path_maps_VV                     | URI Path of Maps                                                                              |          | map(object) | Yes      |
| private_link_config_subnet_VV        | name of the subnet id for private link configuration                                          |          | string      | Yes      |
| private_link_frontend_ip_name_VV     | frontend ip configuration name for private link configuration                                 |          | string      | Yes      |
| domain_name_label_VV                 | The domain name label for public IP. Leave it as null if not needed                           |          | string      | Yes      |

---
