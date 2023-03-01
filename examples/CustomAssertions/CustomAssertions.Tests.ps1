BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Resource Group Exists Using Custom Assertions' {
  it 'Should contain a resource group named testrg' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Resource Group Does Not Exist Using Custom Assertions' {
  it 'Should not contain a resource group named testrg2' {
    #arrange
    $rgName = "testrg2"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName -ErrorAction SilentlyContinue

    #assert
    $result | Should -Not -BeDeployed
  }
}

Describe 'Verify Resource Group Exists in Correct Location' {
  it 'Should contain a resource group named testrg in West US 3' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Resource Group Does Not Exist in Location' {
  it 'Should not contain a resource group named testrg in West US 2' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -Not -BeInLocation 'westus2'
  }
}

Describe 'Verify Continer Registry Exists in Resource Group' {
  it 'Should contain a CR in testrg' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPContainerRegistry -Name "testcontaineregistry" -ResourceGroupName $rgName

    #assert
    $result | Should -BeInResourceGroup 'testrg'
  }
}

Describe 'Verify Continer Registry Does Not Exist in Resource Group' {
  it 'Should not contain a CR in testrg2' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPContainerRegistry -Name "testcontaineregistry" -ResourceGroupName $rgName

    #assert
    $result | Should -Not -BeInResourceGroup 'testrg2'
  }
}
