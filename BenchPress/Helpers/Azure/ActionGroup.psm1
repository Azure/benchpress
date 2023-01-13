<#
.SYNOPSIS
  Helper function for Azure Action Group

.DESCRIPTION
  Helper function for Azure Action Group

.PARAMETER ActionGroupName
  The name of the Azure Action Group

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ActionGroup -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-ActionGroup {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ActionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzActionGroup -ResourceGroupName $ResourceGroupName -Name $ActionGroupName
  return $resource
}

<#
.SYNOPSIS
  Helper function for Azure Action Group

.DESCRIPTION
  Helper function for Azure Action Group

.PARAMETER ActionGroupName
  The name of the Azure Action Group

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ActionGroup-ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-ActionGroup{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ActionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-ActionGroup -ActionGroupName $actionGroupName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-ActionGroup, Get-ActionGroupExists
