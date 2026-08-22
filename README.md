# RishiVora Tech Playground

A Terraform-based Azure infrastructure repository for learning, prototyping, and automating Azure resource deployments with reusable modules and GitHub Actions-based delivery.

## Overview

This repository demonstrates a modular infrastructure-as-code approach for Azure. It separates reusable resource modules from environment-specific project configuration and includes automated deployment through GitHub Actions.

The repo is designed to show how to:

- structure Terraform projects for reuse and scaling
- compose Azure resources using modules
- manage remote state in Azure Storage
- deploy infrastructure through CI/CD pipelines
- keep infrastructure definitions organized and repeatable

## Repository Layout

```text
.
├── .github/
│   └── workflows/
│       └── terraform-cd.yml
├── terraform/
│   ├── modules/
│   │   ├── azurerm_bastion_host/
│   │   ├── azurerm_public_ip/
│   │   ├── azurerm_resource_group/
│   │   ├── azurerm_subnet/
│   │   └── azurerm_virtual_network/
│   └── projects/
│       └── azure-resource-group/
│           ├── main.tf
│           ├── provider.tf
│           ├── terraform.tfvars
│           └── variable.tf
├── .gitignore
├── README.md
└── LICENSE (if added later)
```

## Core Components

### Terraform Modules

The modules under `terraform/modules` encapsulate Azure services and can be reused across different projects:

- `azurerm_resource_group` – creates Azure resource groups
- `azurerm_virtual_network` – provisions virtual networks
- `azurerm_subnet` – provisions subnets
- `azurerm_public_ip` – creates public IP resources
- `azurerm_bastion_host` – provisions Azure Bastion for secure access

### Sample Project

The sample project under `terraform/projects/azure-resource-group` demonstrates how to consume the modules and define environment-specific values.

Example variable structure:

```hcl
azurerm_resource_name = {
  RG1 = {
    name     = "RG-test2"
    location = "centralindia"
  }
}
```

## Prerequisites

Before using this repository, ensure the following are available:

- Terraform v1.4+ installed locally
- Azure subscription with permission to create resources
- Azure CLI installed and authenticated
- A storage account and container for remote Terraform state
- A service principal or federated identity configured for CI/CD authentication

## Local Setup

### 1. Authenticate to Azure

```bash
az login
```

If needed, set the correct subscription:

```bash
az account set --subscription "<your-subscription-name-or-id>"
```

### 2. Initialize the Project

```bash
cd terraform/projects/azure-resource-group
terraform init
```

### 3. Review Changes

```bash
terraform plan
```

### 4. Apply Infrastructure

```bash
terraform apply
```

### 5. Destroy Infrastructure

```bash
terraform destroy
```

## Remote State Configuration

This project uses AzureRM backend configuration for Terraform state storage.

The backend is defined in `terraform/projects/azure-resource-group/provider.tf` and includes values for:

- resource group name
- storage account name
- container name
- state file key

Important: update these values to match your Azure environment before deploying to a real subscription.

## CI/CD Deployment

GitHub Actions automation is defined in `.github/workflows/terraform-cd.yml`.

The workflow performs the following steps:

1. checks out the repository
2. installs Terraform
3. authenticates to Azure using `AZURE_CREDENTIALS`
4. runs `terraform init`
5. runs `terraform apply -auto-approve`

This is a manual deployment workflow triggered via `workflow_dispatch`.

## Security Considerations

Because this project provisions Azure resources, keep the following in mind:

- never commit secrets or service principal credentials to Git
- store Azure credentials in GitHub Secrets
- keep backend storage configuration environment-specific
- review IAM permissions before production use
- validate Terraform changes before applying to shared environments

## Suggested Use

This repository is suitable for:

- Azure infrastructure learning
- Terraform module experimentation
- cloud architecture prototyping
- GitHub Actions deployment testing

## Operational Notes

- The project is intentionally modular so additional Azure services can be added as needed.
- The backend configuration should be adjusted for each environment, such as dev, test, and prod.
- Future improvements could include separate environment directories, state locking, policy checks, and validation pipelines.

## License

This repository is intended for learning, experimentation, and personal infrastructure practice. Update the license as needed for your intended usage.

## Contributing

If you plan to extend the repository, prefer:

- small, reusable Terraform modules
- clear variables and naming conventions
- environment-safe backend configuration
- validation through `terraform plan` before apply
