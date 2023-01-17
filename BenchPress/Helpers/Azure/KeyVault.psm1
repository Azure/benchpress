<#
.SYNOPSIS
  Helper function for KeyVault

.DESCRIPTION
  Helper function for KeyVault

.PARAMETER Name
  The name of the KeyVault

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-KeyVault -Name "kvbenchpresstest" -ResourceGroupName "rgbenchpresstest"
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
Helper function for KeyVault

.DESCRIPTION
  Helper function for KeyVault

.PARAMETER Name
  The name of the KeyVault

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-KeyVaultExist -Name "kvbenchpresstest" -ResourceGroupName "rgbenchpresstest"
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
  Helper function for KeyVault Secrets

.DESCRIPTION
  Helper function for KeyVault Secrets

.PARAMETER Name
  The name of the KeyVault Secret

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultSecret -Name "samplesecret" -KeyVaultName "kvbenchpresstest"
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
  Helper function for KeyVault Secrets

.DESCRIPTION
  Helper function for KeyVault Secrets

.PARAMETER Name
  The name of the KeyVault Secret

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultSecretExist -Name "samplesecret" -KeyVaultName "kvbenchpresstest"
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
  Helper function for KeyVault Keys

.DESCRIPTION
  Helper function for KeyVault Keys

.PARAMETER Name
  The name of the KeyVault Key

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultKey -Name "samplekey" -KeyVaultName "kvbenchpresstest"
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
  Helper function for KeyVault Keys

.DESCRIPTION
  Helper function for KeyVault Keys

.PARAMETER Name
  The name of the KeyVault Key

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultKeyExist -Name "samplekey" -KeyVaultName "kvbenchpresstest"
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
  Helper function for KeyVault Certificates

.DESCRIPTION
  Helper function for KeyVault Certificates

.PARAMETER Name
  The name of the KeyVault Certificate

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultCertificate -Name "samplecertificate" -KeyVaultName "kvbenchpresstest"
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
  Helper function for KeyVault Certificates

.DESCRIPTION
  Helper function for KeyVault Certificates

.PARAMETER Name
  The name of the KeyVault Certificate

.PARAMETER KeyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultCertificateExist -Name "samplecertificate" -KeyVaultName "kvbenchpresstest"
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
