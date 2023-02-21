using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that a Container Registry exists.

.DESCRIPTION
  The Confirm-AzBPContainerRegistry cmdlet gets a Container Registry using the specified Container Registry and
  Resource Group name.

.PARAMETER Name
  The name of the Container Registry

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPContainerRegistry -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-ContainerRegistry {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzContainerRegistry -ResourceGroupName $ResourceGroupName -Name $Name

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

Export-ModuleMember -Function Confirm-ContainerRegistry
