<#
.SYNOPSIS
  Gets an Action Group.

.DESCRIPTION
  The Get-AzBPActionGroup cmdlet gets an action group using the specified Action Group and Resource Group name.

.PARAMETER ActionGroupName
  The name of the Azure Action Group

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPActionGroup -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.Insights.OutputClasses.PSActionGroupResource
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
  Gets if an Action Group exists.

.DESCRIPTION
  The Get-AzBPActionGroupExist cmdlet checks if an action group exists using the specified Action Group and
  Resource Group name.

.PARAMETER ActionGroupName
  The name of the Azure Action Group

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPActionGroupExist -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-ActionGroupExist {
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

Export-ModuleMember -Function Get-ActionGroup, Get-ActionGroupExist


