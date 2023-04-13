using module ./../../Classes/ResourceType.psm1

BeforeDiscovery {
  $testCases = @()

  foreach ($resourceType in [ResourceType].GetEnumNames())
  {
    $functionName = "Confirm-$resourceType"

    # build test case array
    $testObject = @{
      ResourceType = $resourceType
      Expected = $functionName
    }

    $testCases+=$testObject
  }
}

BeforeAll {
  . $PSScriptRoot/../../Public/Get-ResourceByType.ps1

  foreach ($resourceType in [ResourceType].GetEnumNames())
  {
    $functionName = "Confirm-$resourceType"
    $fileName = "$functionName.ps1"

    # dot-source the powershell function
    . $PSScriptRoot/../../Public/$fileName
  }
}

Describe "Get-ResourceByType" {
  Context "unit tests" -Tag "Unit" {
    It "Calls <expected> when <resourceType> is used" -TestCases $testCases {
      $params = @{
        ResourceName = 'resourcename'
        ResourceGroupName = 'resourcegroupname'
        ResourceType = $ResourceType
        ServerName = 'servername'
        DataFactoryName = 'datafactoryname'
        NamespaceName = 'namespacename'
        EventHubName = 'eventhubname'
        WorkspaceName = 'workspacename'
        AccountName = 'accountname'
        ServicePrincipalId = 'serviceprincipalid'
        Scope = '/subscriptions/'
        RoleDefinitionName = 'roledefinitionname'
        ServiceName = 'servicename'
        ClusterName = 'clustername'
        JobName = 'jobname'
        KeyVaultName = "keyvaultname"
        RoleAssignmentId = 'roleassignmentid'
        RoleDefinitionId = 'roledefinitionid'
        ResourceId = 'resourceid'
      }

      $functionName = "Confirm-$ResourceType"
      $requiredParams = (Get-Command -Name $functionName).ParameterSets[0].Parameters
      | Where-Object IsMandatory -eq True | Select-Object Name

      # create list of expressions like '$<parameter> -ne $null'
      $filters = $requiredParams
      | Select-Object  @{label='Filter';expression={'$' + $_.name + ' -ne $null'}}

      # create joint expression for verifying function is called with
      # all required parameters (ie parameter values are not null)
      $filterString = $filters | Join-String -Property Filter -Separator " and "

      Mock $functionName {}

      Get-ResourceByType @params
      | Should -Invoke -CommandName $Expected -Times 1 -ParameterFilter {$filterString}
    }
  }
}

AfterAll {
}
