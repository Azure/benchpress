BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:accountName = 'azbenchpressstorage'
  $Script:location = 'westus3'
}

Describe 'Verify Storage Account' {
  BeforeAll {
    $Script:noAccountName = 'noazbenchpressstorage'
  }

  It 'Should contain a Storage Account with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName = $accountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Storage Account named $accountName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName = $accountName
      PropertyKey = 'StorageAccountName'
      PropertyValue = $accountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Storage Account with the given name' {
    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Storage Account with the given name' {

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $noAccountName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Storage Account named $accountName" {
    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Storage Account named $accountName in $location" {
    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName
    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Storage Account in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Storage Container' {
  BeforeAll {
    $Script:containerName = 'azbenchpresscontainer'
    $Script:noContainerName = 'noazbenchpresscontainer'
  }

  It 'Should contain a Storage Container with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName = $accountName
      ResourceName = $containerName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Storage Container named $containerName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName = $accountName
      ResourceName = $containerName
      PropertyKey = 'Name'
      PropertyValue = $containerName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Storage Container with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $containerName
    }

    #act
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should not contain a Storage Container with the given name" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $noContainerName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Storage Container named $containerName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $containerName
    }

    #act
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
