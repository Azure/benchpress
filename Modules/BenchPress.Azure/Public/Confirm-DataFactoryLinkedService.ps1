# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-DataFactoryLinkedService {
  <#
    .SYNOPSIS
      Confirms that a Data Factory exists.

    .DESCRIPTION
      The Confirm-AzBPDataFactoryLinkedService cmdlet gets a data factory linked service using the specified
      Data Factory, Linked Service and Resource Group name.

    .PARAMETER Name
      The name of the Linked Service

    .PARAMETER DataFactoryName
      The name of the Data Factory

    .PARAMETER ResourceGroupName
      The name of the Resource Group

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
    $resource = Get-AzDataFactoryV2LinkedService -ResourceGroupName $ResourceGroupName `
      -DataFactoryName $DataFactoryName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
