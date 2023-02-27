#Requires -Module Pester

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

function BeInResourceGroup ($ActualValue, [string]$ExpectedValue, [switch] $Negate, [string] $Because) {
    [bool] $succeeded = $ActualValue.ResourceDetails.ResourceGroupName -eq $ExpectedValue
    if ($Negate) { $succeeded = -not $succeeded }

    if (-not $succeeded) {
        if ($Negate) {
            $failureMessage = "Resource not in resource group. This is expected for $ExpectedValue"
        }
        else {
          $failureMessage = "Resource not in resource group or there was an error when confirming resource."
          if ($Because) { $failureMessage = "Resource not in resource group. This failed $Because." }
        }
    }

    return [pscustomobject]@{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
    }
}

Add-ShouldOperator -Name BeInResourceGroup `
    -InternalName 'BeInResourceGroup' `
    -Test ${function:BeInResourceGroup} `
    -Alias 'BIRG'
