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
  $rgProperty = 'ResourceGroup'
  $rgNameProperty = 'ResourceGroupName'
  $idProperty = 'Id'

  if ($null -eq $ActualValue){
    [bool] $succeeded = $false
    $failureMessage = "ConfirmResult is null or empty."
  } else {
    if ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$rgProperty]){
      $resourceGroupName = $ActualValue.ResourceDetails.$rgProperty
    } elseif ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$rgNameProperty]){
      $resourceGroupName = $ActualValue.ResourceDetails.$rgNameProperty
    } elseif ([bool]$ActualValue.ResourceDetails.PSObject.Properties[$idProperty]){
      # If it does not have a property for resource group but it has an Id,
      # then we can get it from Id
      # ex: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
      $resourceId = $ActualValue.ResourceDetails.$idProperty
      $resourceGroupPath = $resourceId -split 'resourceGroups' | Select-Object -Last 1
      $resourceGroupName = @($resourceGroupPath -split '/')[1]

      # If $resourceGroupName is empty, the Id is the wrong format
      # so, set it to null
      if ('' -eq $resourceGroupName) {
        $resourceGroupName = $null
      }
    }

    # Some resources don't have any of the resource group properties
    if ($null -eq $resourceGroupName){
      [bool] $succeeded = $false
      $failureMessage = "Resource does not have a ResourceGroup, a ResourceGroupName, or an Id (with a RG) property. They are null or empty."
    } else {
        [bool] $succeeded = $resourceGroupName -eq $ExpectedValue
        if ($Negate) { $succeeded = -not $succeeded }

        if (-not $succeeded) {
            if ($Negate) {
              $failureMessage = "Resource is deployed, incorrectly, in $resourceGroupName."
            } else {
              $failureMessage = "Resource not in resource group or there was an error when confirming resource.
              Expected $ExpectedValue but got $resourceGroupName."
              if ($Because) { $failureMessage = "Resource not in resource group. This failed $Because." }
            }
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
