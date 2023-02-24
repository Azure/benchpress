using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1

function Confirm-KeyVaultCertificate {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Certificate exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultCertificate cmdlet gets a Key Vault Certificate using the specified Key Vault and
      Certificate name.

    .PARAMETER Name
      The name of the Certificate

    .PARAMETER KeyVaultName
      The name of the Key Vault

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
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzKeyVaultCertificate -Name $Name -VaultName $KeyVaultName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}
