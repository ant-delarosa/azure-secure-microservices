output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "client_id" {
  value = azuread_application.gitlab_app.client_id
}

output "client_secret" {
  value     = azuread_application_password.gitlab_secret.value
  sensitive = true
}

output "subscription_id" {
  value = var.subscription_id
}

output "tenant_id" {
  value = var.tenant_id
}



