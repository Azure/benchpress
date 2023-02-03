<#
.SYNOPSIS
  Gets a Web App.

.DESCRIPTION
  The Get-AzBPWebApp cmdlet gets a Web App using the specified Web App and
  Resource Group name.

.PARAMETER WebAppName
  The name of the Web App

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPWebApp -WebAppName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.WebApps.Models.PSSite
#>
function Get-WebApp {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WebAppName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName
  return $resource
}

<#
.SYNOPSIS
  Gets if a Web App exists.

.DESCRIPTION
  The Get-AzBPWebAppExist cmdlet checks if a Web App exists using the specified
  Web App and Resource Group name.

.PARAMETER WebAppName
  The name of the Web App

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPWebAppExist -WebAppName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-WebAppExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WebAppName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-WebApp -WebAppName $WebAppName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-WebApp, Get-WebAppExist


