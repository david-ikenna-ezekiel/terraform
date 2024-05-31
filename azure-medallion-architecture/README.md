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

2. Initialize Terraform
    ```sh
    terraform init
    ```

3. Apply the configuration
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
