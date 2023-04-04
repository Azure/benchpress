# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ContainerAppManagedEnv {
  <#
    .SYNOPSIS
      Confirms that a Container App Managed Environment exists.

    .DESCRIPTION
      The Confirm-AzBPContainerAppManagedEnv cmdlet gets a Managed Environment using the specified Managed Environment
      and Resource Group names.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER Name
      The name of the Environment.

    .EXAMPLE
      Confirm-AzBPContainerAppManagedEnv -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzContainerAppManagedEnv -ResourceGroupName $ResourceGroupName -EnvName $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
