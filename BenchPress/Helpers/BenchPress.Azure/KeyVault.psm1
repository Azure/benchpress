<#
.SYNOPSIS
  Gets a Key Vault.

.DESCRIPTION
  The Get-AzBPKeyVault cmdlet gets a Key Vault using the specified Key Vault and
  Resource Group name.

.PARAMETER Name
  The name of the Key Vault

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPKeyVault -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.KeyVault.Models.PSKeyVault
#>
function Get-KeyVault {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $Name
  return $resource
}

<#
.SYNOPSIS
  Gets if a Key Vault exists.

.DESCRIPTION
  The Get-AzBPKeyVaultExist cmdlet checks if a Key Vault exists using the specified
  Key Vault and Resource Group name.

.PARAMETER Name
  The name of the Key Vault

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPKeyVaultExist -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-KeyVaultExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )

  $resource = Get-KeyVault -Name $Name -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Gets a Key Vault Secret.

.DESCRIPTION
  The Get-AzBPKeyVaultSecret cmdlet gets a Key Vault Secret using the specified Key Vault and
  Secret name.

.PARAMETER Name
  The name of the Secret

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultSecret -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultSecret
#>
function Get-KeyVaultSecret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-AzKeyVaultSecret -Name $Name -VaultName $KeyVaultName
  return $resource
}

<#
.SYNOPSIS
  Gets if a Key Vault Secret exists.

.DESCRIPTION
  The Get-AzBPKeyVaultSecretExist cmdlet checks if a Key Vault Secret exists using the specified
  Key Vault and Secret name.

.PARAMETER Name
  The name of the Secret

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultSecretExist -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-KeyVaultSecretExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-KeyVaultSecret -Name $Name -KeyVaultName $KeyVaultName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Gets a Key Vault Key.

.DESCRIPTION
  The Get-AzBPKeyVaultKey cmdlet gets a Key Vault Key using the specified Key Vault and
  Key name.

.PARAMETER Name
  The name of the Key

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultKey -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultKey
#>
function Get-KeyVaultKey {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-AzKeyVaultKey -Name $Name -VaultName $KeyVaultName
  return $resource
}

<#
.SYNOPSIS
  Gets if a Key Vault Key exists.

.DESCRIPTION
  The Get-AzBPKeyVaultKeyExist cmdlet checks if a Key Vault Key exists using the specified
  Key Vault and Key name.

.PARAMETER Name
  The name of the Key

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultKeyExist -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-KeyVaultKeyExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-KeyVaultKey -Name $Name -KeyVaultName $KeyVaultName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Gets a Key Vault Certificate.

.DESCRIPTION
  The Get-AzBPKeyVaultCertificate cmdlet gets a Key Vault Certificate using the specified Key Vault and
  Certificate name.

.PARAMETER Name
  The name of the Certificate

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultCertificate -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.KeyVault.Models.PSKeyVaultCertificate
#>
function Get-KeyVaultCertificate {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-AzKeyVaultCertificate -Name $Name -VaultName $KeyVaultName
  return $resource
}

<#
.SYNOPSIS
  Gets if a Key Vault Certificate exists.

.DESCRIPTION
  The Get-AzBPKeyVaultCertificateExist cmdlet checks if a Key Vault Certificate exists using the specified
  Key Vault and Certificate name.

.PARAMETER Name
  The name of the Certificate

.PARAMETER KeyVaultName
  The name of the Key Vault

.EXAMPLE
  Get-AzBPKeyVaultCertificateExist -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-KeyVaultCertificateExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName
  )

  $resource = Get-KeyVaultCertificate -Name $Name -KeyVaultName $KeyVaultName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-KeyVault, Get-KeyVaultExist, Get-KeyVaultSecret, Get-KeyVaultSecretExist, Get-KeyVaultKey, Get-KeyVaultKeyExist, Get-KeyVaultCertificate, Get-KeyVaultCertificateExist



