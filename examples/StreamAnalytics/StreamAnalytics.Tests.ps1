BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psd1
}

Describe 'Verify Stream Analytics Cluster' {
  it 'Should contain a Stream Analytics Cluster with the given name' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Cluster named teststreamcluster' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a Stream Analytics Cluster named teststreamcluster in westus3' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name
    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be a Stream Analytics Cluster in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Stream Analytics Jobs' {
  it 'Should contain a Stream Analytics Job with the given name' {
    #arrange
    $rgName = 'rg-test'
    $name = 'testjob'

    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Job named testjob' {
    #arrange
    $rgName = 'rg-test'
    $name = 'testjob'

    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a Stream Analytics Job named teststreamcluster in testjob' {
    #arrange
    $rgName = 'rg-test'
    $name = 'testjob'

    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $name
    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be a Stream Analytics Job in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $name = 'testjob'

    #act
    $result = Confirm-AzBPStreamAnalyticsJob -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

#######################################################################################################################

  it 'Should contain a Stream Analytics Function with the given name' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testfunction'

    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Function named testfunction' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testfunction'

    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should be a Stream Analytics Function in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testfunction'

    #act
    $result = Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

#######################################################################################################################

  it 'Should contain a Stream Analytics Input with the given name' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testinput'

    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Input named testinput' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testinput'

    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should be a Stream Analytics Input in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testinput'

    #act
    $result = Confirm-AzBPStreamAnalyticsInput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

#######################################################################################################################

  it 'Should contain a Stream Analytics Output with the given name' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testoutput'

    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Output named testoutput' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testoutput'

    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should be a Stream Analytics Output in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testoutput'

    #act
    $result = Confirm-AzBPStreamAnalyticsOutput -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

#######################################################################################################################

  it 'Should contain a Stream Analytics Transformation with the given name' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testtransformation'

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Stream Analytics Transformation named testtransformation' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testtransformation'

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should be a Stream Analytics Transformation in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $jobName = 'testjob'
    $name = 'testtransformation'

    #act
    $result = Confirm-AzBPStreamAnalyticsTransformation -ResourceGroupName $rgName -JobName $jobName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

AfterAll {
  Get-Module BenchPress.Azure | Remove-Module
}
