resource "azuread_application" "gitlab_app" {
  display_name = "gitlab-cicd-app"
}

resource "azuread_service_principal" "gitlab_sp" {
  client_id = azuread_application.gitlab_app.client_id
}

resource "azuread_application_password" "gitlab_secret" {
  application_id = azuread_application.gitlab_app.id
  display_name   = "gitlab-cicd-secret"
}

# Give the Service Principal access to ACR
resource "azurerm_role_assignment" "acr_push" {
  principal_id         = azuread_service_principal.gitlab_sp.object_id
  role_definition_name = "AcrPush"
  scope                = azurerm_container_registry.acr.id
}

# Give the Service Principal access to AKS
resource "azurerm_role_assignment" "aks_admin" {
  principal_id         = azuread_service_principal.gitlab_sp.object_id
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  scope                = azurerm_kubernetes_cluster.aks.id
}

resource "azurerm_role_assignment" "aks_user" {
  principal_id         = azuread_service_principal.gitlab_sp.object_id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  scope                = azurerm_kubernetes_cluster.aks.id
}

# Get kubelet identity from the default node pool
data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_resource_group.main.name
}

#give access to pull images
resource "azurerm_role_assignment" "acr_pull_kubelet" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = data.azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Give the Service Principal access to delete images in ACR
resource "azurerm_role_assignment" "acr_delete" {
  principal_id         = azuread_service_principal.gitlab_sp.object_id
  role_definition_name = "AcrDelete"
  scope                = azurerm_container_registry.acr.id
}