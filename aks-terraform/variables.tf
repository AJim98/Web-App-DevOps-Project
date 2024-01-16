# aks-terraform/variables.tf file

variable "client_id"{
    description = "Access key for provider"
    type = string

}

variable "client_secret"{
    description = "Secret key for provider"
    type = string

}

variable "subscription_id"{
    description = "Azure subscription ID"
    type = string
}

variable "tenant_id"{
    description = "Azure tenant ID"
    type = string
}

variable "ip_address" {
    description = "Personal IP address"
    type = string
}