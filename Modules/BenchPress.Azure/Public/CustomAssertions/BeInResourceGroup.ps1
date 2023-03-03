function ShouldBeInResourceGroup ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
  <#
    .SYNOPSIS
      Custom Assertion function to check resource's resource group.

    .DESCRIPTION
      BeInResourceGroup is a custom assertion that checks the resource group of a resource.
      It can be used when writing Pester tests.

    .EXAMPLE
      $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName

      $result | Should -BeInResourceGroup 'testrg'

    .EXAMPLE
      $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName

      $result | Should -Not -BeInResourceGroup 'testrg2'

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
    $failureMessage = "ConfirmResult is null or empty."
  }
  else {
    $resourceGroupName = $ActualValue.ResourceDetails.ResourceGroupName

    [bool] $succeeded = $resourceGroupName -eq $ExpectedValue
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
        if ($Negate) {
          $failureMessage = "Resource is deployed, incorrectly, in $resourceGroupName."
        }
        else {
          $failureMessage = "Resource not in resource group or there was an error when confirming resource.
          Expected $ExpectedValue but got $resourceGroupName."
          if ($Because) { $failureMessage = "Resource not in resource group. This failed $Because." }
        }
    }
  }

  return [pscustomobject]@{
      Succeeded      = $succeeded
      FailureMessage = $failureMessage
  }
}

Add-ShouldOperator -Name BeInResourceGroup `
    -InternalName 'ShouldBeInResourceGroup' `
    -Test ${function:ShouldBeInResourceGroup} `
    -Alias 'SBIRG'
