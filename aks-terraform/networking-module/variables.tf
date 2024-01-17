# variables.tf

variable "resource_group_name" {
    description = "The name of the Azure resource group that will be used."
    type = string
}

variable "location" {
    description = "Specifies Azure region resources are deployed to."
    type = string
}

variable "vnet_address_space" {
    description = "Specifies address space for virtual network (VNet)"
    type = list(string)
}

