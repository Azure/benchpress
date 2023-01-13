<#
.SYNOPSIS
  Helper function for KeyVault

.DESCRIPTION
  Helper function for KeyVault

.PARAMETER name
  The name of the KeyVault

.PARAMETER resourceGroupName
  The name of the resource group

.EXAMPLE
  Get-KeyVault -name "kvbenchpresstest" -resourceGroupName "rgbenchpresstest"
#>
function Get-KeyVault {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzKeyVault -ResourceGroupName $resourceGroupName -VaultName $name
  return $resource
}

<#
.SYNOPSIS
Helper function for KeyVault

.DESCRIPTION
  Helper function for KeyVault

.PARAMETER name
  The name of the KeyVault

.PARAMETER resourceGroupName
  The name of the resource group

.EXAMPLE
  Get-KeyVaultExists -name "kvbenchpresstest" -resourceGroupName "rgbenchpresstest"
#>
function Get-KeyVaultExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$resourceGroupName
  )
  $resource = Get-KeyVault $name $resourceGroupName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Helper function for KeyVault Secrets

.DESCRIPTION
  Helper function for KeyVault Secrets

.PARAMETER name
  The name of the KeyVault Secret

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultSecret -name "samplesecret" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultSecret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-AzKeyVaultSecret -Name $name -VaultName $keyVaultName
  return $resource
}

<#
.SYNOPSIS
  Helper function for KeyVault Secrets

.DESCRIPTION
  Helper function for KeyVault Secrets

.PARAMETER name
  The name of the KeyVault Secret

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultSecretExists -name "samplesecret" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultSecretExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-KeyVaultSecret $name $keyVaultName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Helper function for KeyVault Keys

.DESCRIPTION
  Helper function for KeyVault Keys

.PARAMETER name
  The name of the KeyVault Key

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultKey -name "samplekey" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultKey {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-AzKeyVaultKey -Name $name -VaultName $keyVaultName
  return $resource
}

<#
.SYNOPSIS
  Helper function for KeyVault Keys

.DESCRIPTION
  Helper function for KeyVault Keys

.PARAMETER name
  The name of the KeyVault Key

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultKeyExists -name "samplekey" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultKeyExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-KeyVaultKey $name $keyVaultName
  return ($null -ne $resource)
}

<#
.SYNOPSIS
  Helper function for KeyVault Certificates

.DESCRIPTION
  Helper function for KeyVault Certificates

.PARAMETER name
  The name of the KeyVault Certificate

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultCertificate -name "samplecertificate" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultCertificate {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-AzKeyVaultCertificate -Name $name -VaultName $keyVaultName
  return $resource
}

<#
.SYNOPSIS
  Helper function for KeyVault Certificates

.DESCRIPTION
  Helper function for KeyVault Certificates

.PARAMETER name
  The name of the KeyVault Certificate

.PARAMETER keyVaultName
  The name of the KeyVault

.EXAMPLE
  Get-KeyVaultCertificateExists -name "samplecertificate" -keyVaultName "kvbenchpresstest"
#>
function Get-KeyVaultCertificateExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$name,

    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
  )
  $resource = Get-KeyVaultCertificate $name $keyVaultName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-KeyVault, Get-KeyVaultExists, Get-KeyVaultSecret, Get-KeyVaultSecretExists, Get-KeyVaultKey, Get-KeyVaultKeyExists, Get-KeyVaultCertificate, Get-KeyVaultCertificateExists
