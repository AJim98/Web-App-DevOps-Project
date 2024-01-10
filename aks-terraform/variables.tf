# aks-terraform/variables.tf file

variable "client_id"{
    description = "Access key for provider"
    type = string
    sensitive = true
}

variable "client_secret"{
    description = "Secret key for provider"
    type = string
    sensitive = true
}

variable "subscription_id"{
    description = "Azure subscription ID"
    type = string
    sensitive = true
}

variable "tenant_id"{
    description = "Azure tenant ID"
    type = string
    sensitive = true
}

variable "resource_group_name"{
    description = "Resource group name for networking"
    type = string
    default = "networkingproject_resource_group"
}

variable "location"{
    description = "Networking module location"
    type = string
    default = "UK South"
}

variable "vnet_address_space"{
    description = "Address for networking virtual address"
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "cluster_name"{
    description = "AKS cluster's name"
    type = string
    default = "terraform-aks-cluster"
}

variable "dns_prefix"{
    description = "DNS prefix for AKS cluster"
    type = string
    default = "myaks-project"
}

variable "kubernetes_version"{
    description = "kubernetes version used by AKS cluster"
    type = string
    default = "1.26.6"
}

variable "service_principal_client_id"{
    description = "Client ID for service principal"
    type = string
    sensitive = true
}

variable "service_principal_client_secret"{
    description = "Client secret for service principal"
    type = string
    sensitive = true
}
