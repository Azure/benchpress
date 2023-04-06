using module ./../../Classes/ResourceType.psm1

BeforeAll {
  . $PSScriptRoot/../../Public/Get-ResourceByType.ps1
  $testCases = @()

  foreach ($i in [ResourceType].GetEnumNames())
  {
    $functionName = "Confirm-$i"
    $fileName = "$functionName.ps1"

    # dot-source the powershell function
    . $PSScriptRoot/../../Public/$fileName

    # build test case array
    $testObject = @{
      ResourceType = $resource
      Expected = $functionName
    }

    $testCases+=$testObject
  }
}

Describe "Get-ResourceByType" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      foreach ($i in [ResourceType].GetEnumNames())
      {
        $functionName = "Confirm-$i"
        Mock $functionName {}
      }
    }

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
