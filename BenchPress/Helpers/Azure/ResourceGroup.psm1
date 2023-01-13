<#
.SYNOPSIS
  Helper function for Resource Group

.DESCRIPTION
  Helper function for Resource Group

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ResourceGroup -ResourceGroupName "rgbenchpresstest"
#>
function Get-ResourceGroup {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzResourceGroup $ResourceGroupName
  return $resource
}

<#
.SYNOPSIS
  Helper function for Resource Group

.DESCRIPTION
  Helper function for Resource Group

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ResourceGroup-ResourceGroupName "rgbenchpresstest"
#>
function Get-ResourceGroup{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-ResourceGroup $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-ResourceGroup, Get-ResourceGroupExists
