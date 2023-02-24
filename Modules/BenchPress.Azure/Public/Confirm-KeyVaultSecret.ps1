using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1

function Confirm-KeyVaultSecret {
  <#
    .SYNOPSIS
      Confirms that a Key Vault Secret exists.

    .DESCRIPTION
      The Confirm-AzBPKeyVaultSecret cmdlet gets a Key Vault Secret using the specified Key Vault and
      Secret name.

    .PARAMETER Name
      The name of the Secret

    .PARAMETER KeyVaultName
      The name of the Key Vault

    .EXAMPLE
      Confirm-AzBPKeyVaultSecret -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

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
      $Resource = Get-AzKeyVaultSecret -Name $Name -VaultName $KeyVaultName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}
