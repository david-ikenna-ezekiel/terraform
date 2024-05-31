# Azure Data Lake with Medallion Architecture

This project sets up an Azure Data Lake with the Medallion Architecture (bronze, silver, and gold layers) using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- An Azure account

## Usage

1. Clone the repository
    ```sh
    git clone https://github.com/david-ikenna-ezekiel/terraform.git
    cd azure-medallion-architecture
    ```

2. Create a `terraform.tfvars` file to provide values for the variables. This file is ignored by git and will not be included in the repository.

    ```sh
    touch terraform.tfvars
    ```

    Add the following content to the `terraform.tfvars` file:
    ```hcl
    resource_group_name = "my-data-lake-rg"
    location            = "West Europe"
    storage_account_name = "mystorageaccount"
    ```

3. Initialize Terraform
    ```sh
    terraform init
    ```

4. Apply the configuration
    ```sh
    terraform apply
    ```

    Type `yes` when prompted to confirm the apply action.

## Resources Created

- Azure Resource Group
- Azure Storage Account
- Storage Containers for Bronze, Silver, and Gold layers

## Outputs

- Resource Group Name
- Storage Account Name
- Container Names for Bronze, Silver, and Gold layers

## Notes

- The `terraform.tfvars` file is used to set variable values and is ignored by git for security reasons. Ensure you create this file with appropriate values before running Terraform commands.
