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

| Parameters                                     | Description                                                | Default   | Type         | Required |
|------------------------------------------------|------------------------------------------------------------|-----------|--------------|---------|
| name_VV                                        | Common Name for all                                        |           | string       | Yes     |  
| location_VV                                    | Location of the Resources                                  |           | string       | Yes     |  
| vnet_resource_group_VV                         | Name of the AKS Vnet resource group                        |           | string       | Yes     |
| vnet_VV                                        | Name of AKS VNet                                           |           | string       | Yes     |
| subnet_aks_VV                                  | Name of AKS Subnet                                         |           | string       | Yes     |
| http_listeners_VV                              | Http Listeners                                             |           | map(object)  | Yes     |
| request_routing_rules_VV                       | Requesting Routing Rules                                   |           | map(object)  | Yes     |
| waf_policy_name_VV                             | WAF Policy                                                 |           | string       | Yes     |
| backend_http_settings_VV                       | Backend Http Settings                                      |           | string       | Yes     |
| allocation_method_VV                           | Allocation Method                                          | static    | string       | Yes     |
| sku_public_ip_VV                               | SKU Public Ip                                              | standard  | string       | Yes     |
| backend_address_pool_ip_addresses_VV           | This variable will be removed in future versions.          |           | string       | Yes     |
| backend_address_pool_fqdns_VV                  | This variable will be removed in future versions.          |           | string       | Yes     |
| default_backend_pool_VV                        | Additional backend pools                                   |           | number       | Yes     |
| windows_node_pool_config_VV                    | Windows node pool                                          |           | List(object) | Yes     |
| number_of_linux_node_pools_VV                  | Number of linux user node pools to                         | 0         | number       | Yes     |
| linux_node_pool_config_VV                      | linux node pool configuration                              |           | List(object) | Yes     |
| workload_identity_enabled_VV                   | Defines if workload identity should be enabled on cluster. | true      | bool         | Yes     |
| oidc_issuer_enabled_VV                         | Defines if OIDC issuer should be enabled on                | true      | bool         | Yes     |
| tags_VV                                        | Mapping of tags key-value pairs                            |           | map(string)  | Yes     |


---
