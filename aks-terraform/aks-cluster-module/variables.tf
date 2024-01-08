# aks-cluster-module/variables.tf

variable "aks_cluster_name" {
    description = "Name of AKS Cluster that will be created"
    type = string
}

variable "cluster_location" {
    description = "Specifies Azure region resource where AKS cluster will be deployed to"
    type = string
}

variable "dns_prefix" {
    description = "Defines DNS prefix of cluster"
    type = string
}

variable "kubernetes_version" {
    description = "Specifies which version of kubernetes will be used"
    type = string
}

variable "service_principal_client_id"{
    description = "Provides the Client ID for the service principal associated with the cluster"
    type = string
}

variable "service_principal_secret" {
    description = "Supplies the Client Secret for the service principal"
    type = string
}

# Outputs from networking-module/output.tf being used as inputs for aks-cluster-module/variables.tf

variable "resource_group_name"{
    description = "Resource group name"
    type = string
}

variable "vnet_id" {
    description = "VNet ID"
    type = string
}

variable "control_plane_subnet_id"{
    description = "Control plane subnet ID"
    type = string
}

variable "worker_node_subnet_id" {
    description = "Worker node subnet ID"
    type = string
}
