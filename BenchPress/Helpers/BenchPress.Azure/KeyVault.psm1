using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that a Key Vault exists.

.DESCRIPTION
  The Confirm-AzBPKeyVault cmdlet gets a Key Vault using the specified Key Vault and
  Resource Group name.

.PARAMETER Name
  The name of the Key Vault

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPKeyVault -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-KeyVault {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $Name

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

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
function Confirm-KeyVaultSecret {
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
function Confirm-KeyVaultKey {
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
      $Resource = Get-AzKeyVaultKey -Name $Name -VaultName $KeyVaultName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

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
function Confirm-KeyVaultCertificate {
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

Export-ModuleMember -Function Confirm-KeyVault,
  Confirm-KeyVaultSecret,
  Confirm-KeyVaultKey,
  Confirm-KeyVaultCertificate
