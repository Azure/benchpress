using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that an Action Group exists.

.DESCRIPTION
  The Confirm-AzBPActionGroup cmdlet gets an action group using the specified Action Group and Resource Group name.

.PARAMETER ActionGroupName
  The name of the Azure Action Group

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPActionGroup -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-ActionGroup {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ActionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzActionGroup -ResourceGroupName $ResourceGroupName -Name $ActionGroupName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

Export-ModuleMember -Function Confirm-ActionGroup
