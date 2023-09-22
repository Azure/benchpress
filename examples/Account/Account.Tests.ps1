BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Account' {
  It "Should connected to Azure" {
    # act and assert
    Confirm-AzBPAccount | Should -BeSuccessful
  }

  It "Should not contain an Action Group named $noActionGroupName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $env:AZ_USE_MANAGED_IDENTITY = $false
    $env:AZ_SUBSCRIPTION_ID = ""
    $env:AZ_TENANT_ID = ""
    $env:AZ_APPLICATION_ID = ""
    $env:AZ_ENCRYPTED_PASSWORD = ""

    # act and assert
    Confirm-AzBPAccount @params | Should -Not -BeSuccessful
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
