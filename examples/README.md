# How to Run the Examples

This directory contains examples showing how to use BenchPress functions to test your bicep deployments. Follow the common
steps below to setup your local environment. Then navigate to each subfolder for additional steps to execute the
examples.

## Pre-Requisites

- An Azure subscription to deploy resources to
- A resource group deployed to the Azure subscription
- A [service principal][1] with a client secret created that has contributor access on the Azure subscription

[1]: <https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal>

## Common Steps

1. Follow the [installation guide](../../docs/installation.md) to install `Az-InfrastructureTest` from the PowerShell
Gallery or from a local copy.
1. Follow the Setting Up section in the [getting started guide](../../docs/getting_started.md) to configure the
required environment variables.
