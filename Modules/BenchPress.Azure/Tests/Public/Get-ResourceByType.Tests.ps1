using module ./../../Classes/ResourceType.psm1

BeforeDiscovery {
  $testCases = @()

  foreach ($i in [ResourceType].GetEnumNames())
  {
    $functionName = "Confirm-$i"

    # build test case array
    $testObject = @{
      ResourceType = $i
      Expected = $functionName
    }

    $testCases+=$testObject
  }
}

BeforeAll {
  . $PSScriptRoot/../../Public/Get-ResourceByType.ps1

  foreach ($i in [ResourceType].GetEnumNames())
  {
    $functionName = "Confirm-$i"
    $fileName = "$functionName.ps1"

    # dot-source the powershell function
    . $PSScriptRoot/../../Public/$fileName
  }
}

Describe "Get-ResourceByType" {
  BeforeAll {
    foreach ($i in [ResourceType].GetEnumNames())
    {
      $functionName = "Confirm-$i"
      Mock $functionName {}
    }
  }

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
      }
      Get-ResourceByType @params | Should -Invoke -CommandName $Expected -Times 1
    }
  }
}

AfterAll {
}
