# outputs.tf

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.adls.name
}

output "bronze_container_name" {
  description = "The name of the bronze container"
  value       = azurerm_storage_container.bronze.name
}

output "silver_container_name" {
  description = "The name of the silver container"
  value       = azurerm_storage_container.silver.name
}

output "gold_container_name" {
  description = "The name of the gold container"
  value       = azurerm_storage_container.gold.name
}
