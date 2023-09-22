# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-Account {
  <#
    .SYNOPSIS
      Confirms that the Azure account is connected.

    .DESCRIPTION
      The Confirm-AzBPAccount cmdlet gets the connected Acount using the environment variables.

    .EXAMPLE
      Confirm-AzBPAccount

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzContext

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
