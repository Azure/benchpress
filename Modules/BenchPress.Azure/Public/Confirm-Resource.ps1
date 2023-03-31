# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1
using module ./../Classes/ResourceType.psm1

. $PSScriptRoot/Get-ResourceByType.ps1
# end INLINE_SKIP

function Confirm-Resource {
  <#
    .SYNOPSIS
      Confirms whether a resource exists or properties on a resource are configured correctly.

    .DESCRIPTION
      The Confirm-AzBPResource cmdlet confirms whether an Azure resource exists and/or confirms whether properties
      on a resource exist and are configured to the correct value. The cmdlet will return a ConfirmResult object
      which contains the following properties:
      - Success: True if the resource exists and/or the property is set to the expected value. Otherwise, false.
      - ResourceDetails: System.Object that contains the details of the Azure Resource that is being confirmed.

    .PARAMETER ResourceName
      The name of the Resource

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .PARAMETER ResourceType
      The type of the Resource as a [ResourceType]

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the data factory to which the linked
      service is assigned.

    .PARAMETER WorkspaceName
      If testing a resource that belongs to some sort of Azure workspace (i.e. SQL pool in a Synapse workspace),
      the name of the workspace to which the resource is assigned.

    .PARAMETER AccountName
      If the Azure resource has an associated account name (e.g., Cosmos DB SQL Database, Storage Container)

    .PARAMETER ClusterName
      If the Azure resource is associated with an AKS Cluster (e.g, AKS Node Pool) this is the parameter to use to pass
      the AKS cluster name.

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
        ResourceGroupName = "rg-test";
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
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $false)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ServerName,

    [Parameter(Mandatory = $false)]
    [string]$DataFactoryName,

    [Parameter(Mandatory = $false)]
    [string]$NamespaceName,

    [Parameter(Mandatory = $false)]
    [string]$EventHubName,

    [Parameter(Mandatory = $false)]
    [string]$WorkspaceName,

    [Parameter(Mandatory = $false)]
    [string]$ServicePrincipalId,

    [Parameter(Mandatory = $false)]
    [string]$Scope,

    [Parameter(Mandatory = $false)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory = $false)]
    [string]$AccountName,

    [Parameter(Mandatory = $false)]
    [string]$ServiceName,

    [Parameter(Mandatory = $false)]
    [string]$ClusterName,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue
  )
  Begin { }
  Process {
    $ResourceParams = @{
      ResourceType       = $ResourceType
      NamespaceName      = $NamespaceName
      EventHubName       = $EventHubName
      ResourceName       = $ResourceName
      ResourceGroupName  = $ResourceGroupName
      ServerName         = $ServerName
      DataFactoryName    = $DataFactoryName
      WorkspaceName      = $WorkspaceName
      AccountName        = $AccountName
      RoleDefinitionName = $RoleDefinitionName
      Scope              = $Scope
      ServicePrincipalId = $ServicePrincipalId
      ServiceName        = $ServiceName
      ClusterName        = $ClusterName
    }

    $ConfirmResult = Get-ResourceByType @ResourceParams

    if ($null -eq $ConfirmResult) {
      Write-Error "Resource not found" -Category InvalidResult -ErrorId "InvalidResource"
      $ConfirmResult = [ConfirmResult]::new($null)
    } elseif ($ConfirmResult.Success -and -not [string]::IsNullOrWhiteSpace($PropertyKey)) {
      $ActualValue = $ConfirmResult.ResourceDetails

      # Split property path on open and close square brackets and periods. Remove empty items from array.
      $Keys = ($PropertyKey -split '[\[\]\.]').Where({ $_ -ne "" })
      foreach ($Key in $Keys) {
        try {
          # If key is a numerical value, index into array
          if ($Key -match "^\d+$") {
            $ActualValue = $ActualValue[$Key]
          } else {
            $ActualValue = $ActualValue.$Key
          }
        } catch {
          $thrownError = $_
          $ConfirmResult = [ConfirmResult]::new($null)
          Write-Error $thrownError
          break
        }
      }

      if ($ConfirmResult.Success -and $ActualValue -ne $PropertyValue) {
        $ConfirmResult.Success = $false

        if ($null -eq $ActualValue) {
          $errorParams = @{
            Message  = "A value for the property key: ${$PropertyKey}, was not found."
            Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
            ErrorId  = "InvalidKey"
          }

          Write-Error @errorParams
        } else {
          $errorParams = @{
            Message  = "The value provided: ${$PropertyValue}, does not match the actual value: ${ActualValue} for " +
            "property key: ${$PropertyKey}"
            Category = [System.Management.Automation.ErrorCategory]::InvalidResult
            ErrorId  = "InvalidPropertyValue"
          }

          Write-Error @errorParams
        }
      }
    }

    $ConfirmResult
  }
  End { }
}
