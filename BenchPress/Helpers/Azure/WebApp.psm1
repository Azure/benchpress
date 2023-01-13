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

function Get-WebApp{
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

Export-ModuleMember -Function Get-WebApp, Get-WebAppExists
