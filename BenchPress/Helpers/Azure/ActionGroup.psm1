function Get-ActionGroup {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$actionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzActionGroup -ResourceGroupName $resourceGroupName -Name $actionGroupName
  return $resource
}

function Get-ActionGroupExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$actionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-ActionGroup $actionGroupName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-ActionGroup, Get-ActionGroupExists
