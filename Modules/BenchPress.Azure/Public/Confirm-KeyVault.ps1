# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-KeyVault {
  <#
    .SYNOPSIS
      Confirms that a Key Vault exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVault cmdlet gets a Key Vault using the specified Key Vault and Resource Group names.

    .PARAMETER Name
      The name of the Key Vault.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPKeyVault -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
