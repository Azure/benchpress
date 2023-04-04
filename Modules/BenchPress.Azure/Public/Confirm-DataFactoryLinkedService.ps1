# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-DataFactoryLinkedService {
  <#
    .SYNOPSIS
      Confirms that a Data Factory exists.

    .DESCRIPTION
      The Confirm-AzBPDataFactoryLinkedService cmdlet gets a Data Factory Linked Service using the specified
      Data Factory, Linked Service, and Resource Group names.

    .PARAMETER Name
      The name of the Linked Service.

    .PARAMETER DataFactoryName
      The name of the Data Factory.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPDataFactoryLinkedService -Name "bplinkedservice" -ResourceGroupName "rgbenchpresstest" `
        -DataFactoryName "bpdatafactory"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$DataFactoryName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      DataFactoryName   = $DataFactoryName
      Name              = $Name
    }
    $resource = Get-AzDataFactoryV2LinkedService @params

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
