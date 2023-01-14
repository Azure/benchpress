function Get-SqlServer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName
  return $resource
}

function Get-SqlServerExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-SqlServer -ServerName $ServerName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-SqlServer, Get-SqlServerExist
