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
  $propertyName = 'Location'

  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } elseif (-not [bool]$ActualValue.ResourceDetails.PSObject.Properties[$propertyName]) {
    [bool] $succeeded = $false
    $failureMessage = "Resource does not have a location property. It is null or empty."
  } else {
    # Both expected and actual locations should be normalized with no spaces
    $resourceLocation = $ActualValue.ResourceDetails.Location -replace " ",""
    $expectedLocation = $ExpectedValue -replace " ",""

    [bool] $succeeded = $resourceLocation -ieq $expectedLocation
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
      if ($Negate) {
        $failureMessage = "Resource is deployed, incorrectly, in $resourceLocation."
      } else {
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
