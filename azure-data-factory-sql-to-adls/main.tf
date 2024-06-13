terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0" # Ensure you are using a recent version
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "adls" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "container" {
  name                  = "adventureworks"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  
}

resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "sql_linked_service" {
  name              = "AzureSqlDatabaseLinkedService"
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = "data source=${azurerm_mssql_server.sql_server.fully_qualified_domain_name};initial catalog=${azurerm_mssql_database.sql_db.name};user id=${var.sql_admin_username};password=${var.sql_admin_password};integrated security=False;encrypt=True;connection timeout=30"
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "adls_linked_service" {
  name                  = "ADLSGen2LinkedService"
  data_factory_id       = azurerm_data_factory.adf.id
  service_principal_id  = data.azurerm_client_config.current.client_id
  service_principal_key = var.service_principal_key
  tenant                = data.azurerm_client_config.current.tenant_id
  url                   = "https://${azurerm_storage_account.adls.name}.dfs.core.windows.net"
}

resource "azurerm_data_factory_dataset_azure_sql_table" "sql_dataset" {
  name              = "AzureSqlTableDataset"
  data_factory_id   = azurerm_data_factory.adf.id
  linked_service_id = azurerm_data_factory_linked_service_azure_sql_database.sql_linked_service.id
}

resource "azurerm_data_factory_dataset_azure_blob" "adls_dataset" {
  name                = "AzureBlobDataset"
  data_factory_id     = azurerm_data_factory.adf.id
  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.adls_linked_service.name
  path                = "adventureworks"
  filename = "playground"
  
}

resource "azurerm_data_factory_pipeline" "copy_pipeline" {
  name            = "CopySqlToAdlsPipeline"
  data_factory_id = azurerm_data_factory.adf.id

  activities_json = <<JSON
[
  {
    "name": "CopyFromSqlToAdls",
    "type": "Copy",
    "dependsOn": [],
    "typeProperties": {
      "source": {
        "type": "AzureSqlSource"
      },
      "sink": {
        "type": "AzureBlobFS"
      }
    },
    "inputs": [
        {
        "referenceName": "${azurerm_data_factory_dataset_azure_sql_table.sql_dataset.name}",
        "type": "DatasetReference"
      }
      
    ],
    "outputs": [
      {
        "referenceName": "${azurerm_data_factory_dataset_azure_blob.adls_dataset.name}",
        "type": "DatasetReference"
      }
    ]
  }
]
  JSON
}
