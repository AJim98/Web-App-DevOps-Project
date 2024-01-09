# aks-cluster-module output.tf file

output "aks_cluster_name"{
    description = "Name of AKS cluster"
    value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_kubeconfig" {
  description = "Kubeconfig file for accessing the AKS cluster."
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}

