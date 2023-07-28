# Azure Managed Application - Virtual Machine Deployment

This repository contains an Azure Managed Application for deploying an Azure Virtual Machine.

## Overview

The Azure Managed Application is a solution that enables you to deploy and manage Azure resources as a single unit. This Managed Application deploys an Azure Virtual Machine and provides a simple way to get started with Azure Virtual Machines.

## Prerequisites

Before deploying the Azure Managed Application, you must have the following:

- An Azure subscription
- Azure CLI installed on your local machine
- A Virtual Machine name and resource group name
- A Virtual Network and Subnet

## Deployment

To deploy the Azure Managed Application, follow these steps:

1. Clone this repository to your local machine.
2. Open a command prompt or terminal window and navigate to the root directory of the repository.
3. Run the following command to create a Managed Application definition:

   ```bash
   az managedapp definition create --name <managed-app-name> --location <location> --resource-group <resource-group-name> --lock-level ReadOnly --display-name <display-name> --description <description> --authorizations <authorizations> --package-file-uri <package-file-uri>
   ```
