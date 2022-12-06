function Get-WebApp {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$webAppName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $webAppName
  return $resource
}

function Get-WebAppExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$webAppName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-WebApp $webAppName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-WebApp, Get-WebAppExists
