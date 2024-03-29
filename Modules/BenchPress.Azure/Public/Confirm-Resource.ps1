﻿# INLINE_SKIP
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
      The name of the Resource.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER ResourceType
      The type of the Resource as a [ResourceType].

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the Server to which the Database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the Data Factory to which the Linked
      Service is assigned.

    .PARAMETER NamespaceName
      If testing an Azure resource that is associated with a Namespace (e.g., Event Hub), the name of the associated
      Namespace.

    .PARAMETER EventHubName
      If testing a component of Event Hub (e.g., Consumer Group), the name of the Event Hub to which the component
      is assigned.

    .PARAMETER WorkspaceName
      If testing an Azure resource that belongs to some sort of Azure Workspace (e.g., SQL Pool in a Synapse
      Workspace), the name of the Workspace to which the resource is assigned.

    .PARAMETER AccountName
      If testing an Azure resource that is associated with an Account (e.g., Cosmos DB SQL Database,
      Storage Container), the name of the associated Account.

    .PARAMETER ServicePrincipalId
      If testing an Azure Role Assignment, the Enterprise/Managed Application Object ID of the Service Principal.

    .PARAMETER Scope
      If testing an Azure Role Assignment, the Scope of the Role Assignment (e.g.,
      /subscriptions/{id}/resourceGroups/{resourceGroupName}).
      It must start with "/subscriptions/{id}".

    .PARAMETER RoleDefinitionName
      If testing an Azure Role Assignment, the name of the Role Definition (e.g., Reader, Contributor etc.).

    .PARAMETER ServiceName
      If testing an Azure resource that is associated with a Service (e.g., API Management Service), the name of
      the associated Service.

    .PARAMETER KeyVaultName
      If testing an Azure Key Vault resource (e.g., Key Vault Key), the name of the Key Vault to which the resource is
      assigned.

    .PARAMETER JobName
      If testing an Azure resource that is associated with a Job (e.g., Stream Analytics Output), the name of
      the associated Job.

    .PARAMETER RoleAssignmentId
      If testing an Azure resource that is associated with a Role Assignment (e.g., Cosmos DB SQL Role Assignment),
      the id of the Role Assignment.

    .PARAMETER RoleDefinitionId
      If testing an Azure resource that is associated with a Role Definition (e.g., Cosmos DB SQL Role Definition),
      the id of the Role Definition.

    .PARAMETER ClusterName
      If testing an Azure resource that is associated with an AKS Cluster (e.g, AKS Node Pool) this is the parameter
      to use to pass the AKS cluster name.

    .PARAMETER ResourceId
      If testing an Azure resource that is associated with a Resource ID (e.g., Diagnostic Setting)
      this is the parameter to use to pass the Resource ID.

    .PARAMETER PropertyKey
      The name of the property to check on the resource.

    .PARAMETER PropertyValue
      The expected value of the property to check.

    .EXAMPLE
      Checking whether a resource exists (i.e. Resource Group).
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

    .EXAMPLE
      Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3).
      Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                            -PropertyValue "WestUS3"

    .EXAMPLE
      Checking whether a nested property on a resource is configured correctly (i.e. OS of VM is Linux).

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
    [string]$KeyVaultName,

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
    [string]$JobName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceId,

    [Parameter(Mandatory = $false)]
    [string]$RoleAssignmentId,

    [Parameter(Mandatory = $false)]
    [string]$RoleDefinitionId,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue
  )
  Begin { }
  Process {
    $resourceParams = @{
      ResourceType       = $ResourceType
      NamespaceName      = $NamespaceName
      EventHubName       = $EventHubName
      JobName            = $JobName
      ResourceName       = $ResourceName
      ResourceGroupName  = $ResourceGroupName
      ServerName         = $ServerName
      KeyVaultName       = $KeyVaultName
      DataFactoryName    = $DataFactoryName
      WorkspaceName      = $WorkspaceName
      AccountName        = $AccountName
      RoleDefinitionName = $RoleDefinitionName
      Scope              = $Scope
      ServicePrincipalId = $ServicePrincipalId
      ServiceName        = $ServiceName
      RoleAssignmentId   = $RoleAssignmentId
      RoleDefinitionId   = $RoleDefinitionId
      ClusterName        = $ClusterName
      ResourceId         = $ResourceId
    }

    $confirmResult = Get-ResourceByType @resourceParams

    if ($null -eq $confirmResult) {
      Write-Error "Resource not found" -Category InvalidResult -ErrorId "InvalidResource"
      $confirmResult = [ConfirmResult]::new($null)
    } elseif ($confirmResult.Success -and -not [string]::IsNullOrWhiteSpace($PropertyKey)) {
      $actualValue = $confirmResult.ResourceDetails

      # Split property path on open and close square brackets and periods. Remove empty items from array.
      $keys = ($PropertyKey -split '[\[\]\.]').Where({ $_ -ne "" })
      foreach ($key in $keys) {
        # If key is a numerical value, index into array
        if ($key -match "^\d+$") {
          # Check to be sure the current $actualValue is an array and the index is present
          # Both arrays and lists that have indexers (generic lists as well) implement the IList interface
          if (-not ($actualValue -is [System.Collections.IList])) {
            # It is not indexable
            $errorParams = @{
              Message  = "The path '$PropertyKey' attempted to index into the [$($actualValue.GetType())] object " +
                "that does not implement the [IList] interface."
              Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
              ErrorId  = "InvalidKey"
            }

            Write-Error @errorParams
            $confirmResult = [ConfirmResult]::new($null)
            break
          } elseif ([int]$key -lt 0 -or [int]$key -ge ([System.Collections.IList] $actualValue).Count) {
            # Index out of bounds
            $errorParams = @{
              Message  = "The path '$PropertyKey' with the index [$key] was out of bounds for the array with the " +
                "size $(([System.Collections.IList]$actualValue).Count)"
              Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
              ErrorId  = "InvalidKey"
            }

            Write-Error @errorParams
            $confirmResult = [ConfirmResult]::new($null)
            break
          }

          $actualValue = $actualValue[$key]
        } else {
          # Check to be sure that the next key exists in the object, if it doesn't we fail
          if (-not [bool]($actualValue.PSObject.Properties.Name -match $key)) {
            # There is no property in the object with the key, fail.
            $errorParams = @{
              Message  = "The key '$key' in the path '$PropertyKey' does not exist in the " +
                "[$($confirmResult.ResourceDetails.GetType())] object."
              Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
              ErrorId  = "InvalidKey"
            }

            Write-Error @errorParams
            $confirmResult = [ConfirmResult]::new($null)
            break
          }

          $actualValue = $actualValue.$key
        }
      }

      if ($PropertyValue -ne $null -and $confirmResult.Success -and $actualValue -ne $PropertyValue) {
        $confirmResult.Success = $false

        if ($null -eq $actualValue) {
          $errorParams = @{
            Message  = "A value for the property key: ${$PropertyKey}, was not found."
            Category = [System.Management.Automation.ErrorCategory]::InvalidArgument
            ErrorId  = "InvalidKey"
          }

          Write-Error @errorParams
        } else {
          $errorParams = @{
            Message  = "The value provided: ${$PropertyValue}, does not match the actual value: ${actualValue} for " +
                       "property key: ${$PropertyKey}"
            Category = [System.Management.Automation.ErrorCategory]::InvalidResult
            ErrorId  = "InvalidPropertyValue"
          }

          Write-Error @errorParams
        }
      }
    }

    $confirmResult
  }
  End { }
}
