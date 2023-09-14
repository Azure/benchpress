# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SearchService {
  <#
    .SYNOPSIS
      Confirms that a Search Service exists.

    .DESCRIPTION
      The Confirm-AzBPSearchService cmdlet gets a Search Service using the specified Search Service name and Resource Group name.

    .PARAMETER Name
      The name of the Search Service.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPSearchService -Name "testservice" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$Name,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $requestParams = @{
      ResourceGroupName = $ResourceGroupName
      Name              = $Name
    }

    $resource = Get-AzSearchService @requestParams

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
