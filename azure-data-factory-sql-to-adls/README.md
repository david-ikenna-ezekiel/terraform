# Azure Data Factory SQL to ADLS Gen2

This project sets up an Azure Data Factory pipeline to copy data from an Azure SQL Database to Azure Data Lake Storage Gen2 using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- An Azure account
- Service Principal credentials for Azure (Client ID, Client Secret, and Tenant ID)

## Usage

1. Clone the repository
    ```sh
    git clone https://github.com/david-ikenna-ezekiel/azure-data-factory-sql-to-adls.git
    cd azure-data-factory-sql-to-adls
    ```

2. Create a `terraform.tfvars` file to provide values for the variables. This file is ignored by git and will not be included in the repository.

    ```sh
    touch terraform.tfvars
    ```

    Add the following content to the `terraform.tfvars` file:
    ```hcl
    resource_group_name   = "my-data-factory-rg"
    location              = "East US" # Change this to a region where your subscription can provision resources
    storage_account_name  = "mystorageaccount"
    sql_server_name       = "my-sql-server"
    sql_database_name     = "AdventureWorks"
    sql_admin_username    = "sqladmin"
    sql_admin_password    = "YourStrong@Passw0rd"
    data_factory_name     = "myData
