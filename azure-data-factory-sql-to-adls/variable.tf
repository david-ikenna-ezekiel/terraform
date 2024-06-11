variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US" # Change this to a region where your subscription can provision resources
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL database"
  type        = string
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "data_factory_name" {
  description = "The name of the Data Factory"
  type        = string
}

variable "service_principal_key" {
  description = "The key for the service principal"
  type        = string
  sensitive   = true
}
