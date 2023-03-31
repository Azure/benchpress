# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-KeyVaultKey {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Key exist.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultKey cmdlet gets a Key Vault Key using the specified Key Vault and
      Key name.

    .PARAMETER Name
      The name of the Key

    .PARAMETER KeyVaultName
      The name of the Key Vault

    .EXAMPLE
      Confirm-AzBPKeyVaultKey -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

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
    [string]$KeyVaultName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzKeyVaultKey -Name $Name -VaultName $KeyVaultName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
