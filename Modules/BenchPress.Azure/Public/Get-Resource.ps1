# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Get-Resource {
  <#
    .SYNOPSIS
      Gets one or more resources of a given name.

    .DESCRIPTION
      The Get-AzBPResource cmdlet gets Azure resources of a given name.

    .PARAMETER ResourceName
      The name of the Resources

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Get-AzBPResource -ResourceName "benchpresstest"

    .EXAMPLE
      Get-AzBPResource -ResourceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName
  )
  Begin {
    Connect-Account
  }
  Process {
    if ([string]::IsNullOrEmpty($ResourceGroupName)) {
      return Get-AzResource -Name $ResourceName
    }
    else {
      return Get-AzResource -Name $ResourceName -ResourceGroupName $ResourceGroupName
    }
  }
  End { }
}
