#Requires -Module Pester

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

function BeInLocation ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
    [bool] $succeeded = $ActualValue.ResourceDetails.Location -eq $ExpectedValue
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
        if ($Negate) {
            $failureMessage = "Resource not in location: This is expected for $ExpectedValue"
        }
        else {
            $failureMessage = "Resource not in location."
            if ($Because) { $failureMessage = "Resource not in location $Because." }
        }
    }

    return [pscustomobject]@{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-ShouldOperator -Name BeInLocation `
    -InternalName 'BeInLocation' `
    -Test ${function:BeInLocation} `
    -Alias 'BIL'
