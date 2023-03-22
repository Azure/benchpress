BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
}

Describe 'Verify Stream Analytics Cluster' {
  BeforeAll {
    $Script:clusterName = 'teststreamcluster'
  }

  It 'Should contain a Stream Analytics Cluster with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsCluster"
      ResourceGroupName = $rgName
      ResourceName = $clusterName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Cluster named $clusterName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsCluster"
      ResourceGroupName = $rgName
      ResourceName = $clusterName
      PropertyKey = 'Name'
      PropertyValue = $clusterName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Cluster with the given name' {
    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Cluster named $clusterName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Stream Analytics Cluster named $clusterName in $location" {
    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName
    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Stream Analytics Cluster in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $clusterName

    #assert
    $result | Should -BeInResourceGroup $rgName
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

  It 'Should contain a Stream Analytics Job with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsJob"
      ResourceGroupName = $rgName
      ResourceName = $jobName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Job named $jobName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsJob"
      ResourceGroupName = $rgName
      ResourceName = $jobName
      PropertyKey = 'Name'
      PropertyValue = $jobName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Job with the given name' {
    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Job named $jobName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Stream Analytics Job named $jobName in $location" {
    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName
    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Stream Analytics Job in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $jobName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Stream Analytics Function with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsFunction"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $functionName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Function named $functionName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsFunction"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $functionName
      PropertyKey = 'Name'
      PropertyValue = $functionName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Function with the given name' {
    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $functionName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Function named $functionName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $functionName

    #assert
    $result | Should -BeDeployed
  }

  It "Should be a Stream Analytics Function in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $functionName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Stream Analytics Input with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsInput"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $inputName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Input named $inputName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsInput"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $inputName
      PropertyKey = 'Name'
      PropertyValue = $inputName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Input with the given name' {
    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $inputName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Input named $inputName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $inputName

    #assert
    $result | Should -BeDeployed
  }

  It "Should be a Stream Analytics Input in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $inputName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Stream Analytics Output with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsOutput"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $outputName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Output named $outputName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsOutput"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $outputName
      PropertyKey = 'Name'
      PropertyValue = $outputName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Output with the given name' {
    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $outputName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Output named $outputName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $outputName

    #assert
    $result | Should -BeDeployed
  }

  It "Should be a Stream Analytics Output in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $outputName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Stream Analytics Transformation with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsTransformation"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $transformationName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Transformation named $transformationName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StreamAnalyticsTransformation"
      ResourceGroupName = $rgName
      JobName = $jobName
      ResourceName = $transformationName
      PropertyKey = 'Name'
      PropertyValue = $transformationName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Stream Analytics Transformation with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName = $jobName
      Name = $transformationName
    }

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Stream Analytics Transformation named $transformationName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName = $jobName
      Name = $transformationName
    }

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation @params

    #assert
    $result | Should -BeDeployed
  }

  It "Should be a Stream Analytics Transformation in a resource group named $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      JobName = $jobName
      Name = $transformationName
    }

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
