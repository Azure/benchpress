function ShouldBeSuccessful{
  <#
    .SYNOPSIS
      Custom Assertion function to check status on a resource deployment.

    .DESCRIPTION
      BeSuccessful is a custom assertion that checks the provided ConfirmResult Object for deployment success.
      It can be used when writing Pester tests.

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeSuccessful

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -Not -BeSuccessful

    .INPUTS
      ConfirmResult
      System.Switch
      System.String

    .OUTPUTS
      PSCustomObject
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    $ActualValue,

    [Parameter(Mandatory=$false)]
    [switch]$Negate,

    [Parameter(Mandatory=$false)]
    [string]$Because,

    [Parameter(Mandatory=$false)]
    $CallerSessionState
  )
  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } else {
    [bool] $succeeded = $ActualValue.Success
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
      if ($Negate) {
        $failureMessage = "Resource is currently deployed, but should not be."
      } else {
        $failureMessage = "Resource not deployed or there was an error when confirming resource."
        if ($Because) { $failureMessage = "Resource not available $Because." }
      }
    }
  }

  return [pscustomobject]@{
    Succeeded      = $succeeded
    FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeSuccessful `
    -InternalName 'ShouldBeSuccessful' `
    -Test ${function:ShouldBeSuccessful} `
    -Alias 'SBS'
