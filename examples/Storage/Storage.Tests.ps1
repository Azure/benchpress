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

  It "Should contain a Storage Account named $accountName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName      = $accountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Storage Account named $accountName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageAccount"
      ResourceGroupName = $rgName
      ResourceName      = $accountName
      PropertyKey       = 'StorageAccountName'
      PropertyValue     = $accountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Storage Account named $accountName" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeSuccessful
  }

  It "Should not contain a Storage Account named $noAccountName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $noAccountName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a Storage Account named $accountName in $location" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeInLocation $location
  }

  It "Should contain a Storage Account named $accountName in $rgName" {
    Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $accountName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Storage Container' {
  BeforeAll {
    $Script:containerName = 'azbenchpresscontainer'
    $Script:noContainerName = 'noazbenchpresscontainer'
  }

  It "Should contain a Storage Container named $containerName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName       = $accountName
      ResourceName      = $containerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Storage Container named $containerName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "StorageContainer"
      ResourceGroupName = $rgName
      AccountName       = $accountName
      ResourceName      = $containerName
      PropertyKey       = 'Name'
      PropertyValue     = $containerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Storage Container named $containerName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $containerName
    }

    # act and assert
    Confirm-AzBPStorageContainer @params | Should -BeSuccessful
  }

  It "Should not contain a Storage Container named $noContainerName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $accountName
      Name              = $noContainerName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPStorageContainer @params | Should -Not -BeSuccessful
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
