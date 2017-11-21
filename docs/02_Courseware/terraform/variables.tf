variable "azu_clientid" {
    default = ""
}
variable "azu_clientkey" {
    default = ""
}
variable "azu_subid" {
    default = ""
}
variable "azu_tenantid" {
    default = ""
}
variable "azu_location" {
    description = "Where the Azure resources will live"
    default = "East US"
}
variable "deployment_name" {
    default = "addc delpoy"
}
variable "hostname1" {
    default = "vmaddceus003"
}
variable "hostname2" {
    default = "vmaddceus004"
}
variable "existing_subnet_id" {
  description = "The id for the existing subnet in the existing virtual network"
  default = "/subscriptions//resourceGroups/rgSwiftNetworking/providers/Microsoft.Network/virtualNetworks/VNET-EUS2-01/subnets/AAA"
}