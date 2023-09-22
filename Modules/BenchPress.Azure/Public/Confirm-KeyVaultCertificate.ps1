# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-KeyVaultCertificate {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Certificate exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultCertificate cmdlet gets a Key Vault Certificate using the specified Key Vault and
      Certificate name.

    .PARAMETER Name
      The name of the Certificate.

    .PARAMETER KeyVaultName
      The name of the Key Vault.

    .EXAMPLE
      Confirm-AzBPKeyVaultCertificate -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

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
    $resource = Get-AzKeyVaultCertificate -Name $Name -VaultName $KeyVaultName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
