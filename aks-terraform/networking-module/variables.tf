# variables.tf

variable "resource_group_name" {
    description = "The name of the Azure resource group that will be used."
    type = string
    default = "networkingproject_resource_group"
}

variable "location" {
    description = "Specifies Azure region resources are deployed to."
    type = string
    default = "UK South"
}

variable "vnet_address_space" {
    description = "Specifies address space for virtual network (VNet)"
    type = list(string)
    default = ["10.0.0.0/16"]
}
