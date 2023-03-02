function ShouldBeInLocation ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
  <#
    .SYNOPSIS
      Custom Assertion function to check status on a resource deployment.

    .DESCRIPTION
      BeInLocation is a custom assertion that checks the provided ConfirmResult Object for deployment success.
      It can be used when writing Pester tests.

    .EXAMPLE
      $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

      $result | Should -BeInLocation westus3

    .EXAMPLE
      $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

      $result | Should -Not -BeInLocation westus2

    .INPUTS
      ConfirmResult
      System.Switch
      System.String

    .OUTPUTS
      PSCustomObject
  #>
  if ($null -eq $ActualValue){
    [bool] $succeeded = $false

    if ($Negate) { $succeeded = -not $succeeded }
    $failureMessage = "Confirm result is null or empty."
  }
  else {
    $resourceLocation = $ActualValue.ResourceDetails.Location
    [bool] $succeeded = $resourceLocation -eq $ExpectedValue
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
      if ($Negate) {
        $failureMessage = "Resource not in location: This is expected for $ExpectedValue"
      }
      else {
        $failureMessage = "Resource not in location or there was an error when confirming resource.
        Expected $ExpectedValue but got $resourceLocation."
        if ($Because) { $failureMessage = "Resource not in location $Because." }
      }
    }
  }
  return [pscustomobject]@{
      Succeeded      = $succeeded
      FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeInLocation `
    -InternalName 'ShouldBeInLocation' `
    -Test ${function:ShouldBeInLocation} `
    -Alias 'SBIL'
