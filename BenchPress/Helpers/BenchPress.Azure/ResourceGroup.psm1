<#
.SYNOPSIS
  Gets a Resource Group.

.DESCRIPTION
  The Get-AzBPResourceGroup cmdlet gets a Resource Group using the specified Resource Group and
  Resource Group name.

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPResourceGroup -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup
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
  Gets if a Resource Group exists.

.DESCRIPTION
  The Get-AzBPResourceGroupExist cmdlet checks if a Resource Group exists using the specified
  Resource Group and Resource Group name.

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPResourceGroupExist -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-ResourceGroupExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-ResourceGroup $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-ResourceGroup, Get-ResourceGroupExist
