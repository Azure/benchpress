BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify EventHub' {
  it 'Should contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify EventHub Does Not Exist' {
  it 'Should not contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPEventHub @params -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify EventHub Exists with Custom Assertion' {
  it 'Should contain an EventHub named eventhubtest' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify EventHub Exists in Correct Location' {
  it 'Should contain an EventHub named eventhubtest in westus3' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify EventHub Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
