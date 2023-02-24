. $PSScriptRoot/../Private/Connect-Account.ps1

<#
  .SYNOPSIS
    Deletes Azure resources.

  .DESCRIPTION
    Remove-AzBPBicepFeature cmdlet will take an Azure Resource Group name and delete that resource group and all
    resources contained in it.

  .PARAMETER ResourceGroupName
    Name of the Resource Group to delete

  .EXAMPLE
    Remove-AzBPBicepFeature -ResourceGroupName "rg-test"

  .INPUTS
    System.String

  .OUTPUTS
    None
#>
function Remove-BicepFeature(){
  [CmdletBinding()]
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  Connect-Account

  $resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName
  Remove-AzResourceGroup -Name $resourceGroup -Force
}
