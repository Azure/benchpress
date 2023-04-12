BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
}

Describe 'Verify Stream Analytics Cluster' {
  BeforeAll {
    $Script:clusterName = 'teststreamcluster'
  }

  It "Should contain a Stream Analytics Cluster named $clusterName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsCluster"
      ResourceGroupName = $rgName
      ResourceName      = $clusterName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Cluster named $clusterName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsCluster"
      ResourceGroupName = $rgName
      ResourceName      = $clusterName
      PropertyKey       = 'Name'
      PropertyValue     = $clusterName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Cluster named $clusterName" {
    Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Cluster named $clusterName in $location" {
    Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName | Should -BeInLocation $location
  }

  It "Should contain a Stream Analytics Cluster named $clusterName in $rgName" {
    Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName
    | Should -BeInResourceGroup $rgName
  }
}

Describe 'Stream Analytics Jobs' {
  BeforeAll {
    $Script:jobName = 'testjob'
    $Script:functionName = 'testfunction'
    $Script:inputName = 'testinput'
    $Script:outputName = 'testoutput'
    $Script:transformationName = 'testtransformation'
  }

  It "Should contain a Stream Analytics Job named $jobName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsJob"
      ResourceGroupName = $rgName
      ResourceName      = $jobName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Job named $jobName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsJob"
      ResourceGroupName = $rgName
      ResourceName      = $jobName
      PropertyKey       = 'Name'
      PropertyValue     = $jobName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Job named $jobName" {
    Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Job named $jobName in $location" {
    Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName | Should -BeInLocation $location
  }

  It "Should contain a Stream Analytics Job named $jobName in $rgName" {
    Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Stream Analytics Function named $functionName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsFunction"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $functionName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Function named $functionName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsFunction"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $functionName
      PropertyKey       = 'Name'
      PropertyValue     = $functionName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Function named $functionName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $functionName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsFunction @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Function named $functionName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $functionName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsFunction @params | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Stream Analytics Input named $inputName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsInput"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $inputName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Input named $inputName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsInput"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $inputName
      PropertyKey       = 'Name'
      PropertyValue     = $inputName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Input named $inputName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $inputName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsInput @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Input named $inputName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $inputName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsInput @params | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Stream Analytics Output named $outputName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsOutput"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $outputName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Output named $outputName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsOutput"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $outputName
      PropertyKey       = 'Name'
      PropertyValue     = $outputName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Output named $outputName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $outputName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsOutput @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Output named $outputName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $outputName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsOutput @params | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Stream Analytics Transformation named $transformationName- Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsTransformation"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $transformationName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Transformation named $transformationName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StreamAnalyticsTransformation"
      ResourceGroupName = $rgName
      JobName           = $jobName
      ResourceName      = $transformationName
      PropertyKey       = 'Name'
      PropertyValue     = $transformationName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Transformation named $transformationName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $transformationName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsTransformation @params | Should -BeSuccessful
  }

  It "Should contain a Stream Analytics Transformation named $transformationName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName           = $jobName
      Name              = $transformationName
    }

    # act and assert
    Confirm-AzBPStreamAnalyticsTransformation @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
