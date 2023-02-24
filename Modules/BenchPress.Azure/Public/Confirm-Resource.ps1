using module ./../Classes/ConfirmResult.psm1
using module ./../Classes/ResourceType.psm1

. $PSScriptRoot/Get-ResourceByType.ps1
. $PSScriptRoot/../Private/Format-ErrorRecord.ps1
. $PSScriptRoot/../Private/Format-IncorrectValueError.ps1
. $PSScriptRoot/../Private/Format-PropertyDoesNotExistError.ps1

function Confirm-Resource {
  <#
    .SYNOPSIS
      Confirms whether a resource exists or properties on a resource are configured correctly.

    .DESCRIPTION
      The Confirm-AzBPResource cmdlet confirms whether an Azure resource exists and/or confirms whether properties
      on a resource exist and are configured to the correct value. The cmdlet will return a ConfirmResult object
      which contains the following properties:
      - Success: True if the resource exists and/or the property is set to the expected value. Otherwise, false.
      - Error: System.Management.Automation.ErrorRecord containing an ErrorRecord with a message explaining
                that a resource did not exist or property was not set to the expected value.
      - ResourceDetails: System.Object that contains the details of the Azure Resource that is being confirmed.

    .PARAMETER ResourceName
      The name of the Resource

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .PARAMETER ResourceType
      The type of the Resource (currently supports the following:
      ActionGroup
      AksCluster
      AppServicePlan
      ContainerRegistry
      KeyVault
      ResourceGroup
      SqlDatabase
      SqlServer
      VirtualMachine
      WebApp)

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .PARAMETER PropertyKey
      The name of the property to check on the resource

    .PARAMETER PropertyValue
      The expected value of the property to check

    .EXAMPLE
      Checking whether a resource exists (i.e. Resource Group)
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

    .EXAMPLE
      Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3)
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                            -PropertyValue "WestUS3"

    .EXAMPLE
      Checking whether a nested property on a resource is configured correctly (i.e. OS of VM is Linux)

      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "VirtualMachine";
        ResourceName = "testvm";
        PropertyKey = "StorageProfile.OsDisk.OsType";
        PropertyValue = "Linux"
      }

      $result = Confirm-AzBPResource @params

    .INPUTS
      ResourceType
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [string]$ServerName,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue
  )

  $ResourceParams = @{
    ResourceGroupName = $ResourceGroupName
    ResourceName      = $ResourceName
    ResourceType      = $ResourceType
    ServerName        = $ServerName
  }

  $ConfirmResult = Get-ResourceByType @ResourceParams

  if ($null -eq $ConfirmResult) {
    $ErrorRecord = Format-ErrorRecord -Message "ResourceType is invalid" -ErrorID "InvalidResourceType"
    $ConfirmResult = [ConfirmResult]::new($ErrorRecord, $null)
  }
  elseif ($ConfirmResult.Success) {
    if ($PropertyKey) {
      $ActualValue = $ConfirmResult.ResourceDetails
      # Split property path on open and close square brackets and periods. Remove empty items from array.
      $Keys = ($PropertyKey -split '[\[\]\.]').Where({ $_ -ne "" })
      foreach ($Key in $Keys) {
        # If key is a numerical value, index into array
        if ($Key -match "^\d+$") {
          try {
            $ActualValue = $ActualValue[$Key]
          }
          catch {
            $ErrorRecord = $_
            $ConfirmResult = [ConfirmResult]::new($ErrorRecord, $null)
            break
          }
        }
        else {
          $ActualValue = $ActualValue.$Key
        }
      }
      if ($ActualValue -ne $PropertyValue -and $ConfirmResult.Success -ne $false) {
        if ($ActualValue) {
          $ErrorRecord = `
            Format-IncorrectValueError -ExpectedKey $PropertyKey `
            -ExpectedValue $PropertyValue `
            -ActualValue $ActualValue
          $ConfirmResult = [ConfirmResult]::new($ErrorRecord, $null)
        }
        else {
          $ErrorRecord = Format-PropertyDoesNotExistError -PropertyKey $PropertyKey
          $ConfirmResult = [ConfirmResult]::new($ErrorRecord, $null)
        }
      }
    }
  }

  $ConfirmResult
}
