output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.adls.name
}

output "sql_server_name" {
  description = "The name of the SQL server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  description = "The name of the SQL database"
  value       = azurerm_mssql_database.sql_db.name
}

output "data_factory_name" {
  description = "The name of the Data Factory"
  value       = azurerm_data_factory.adf.name
}
