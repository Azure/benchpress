BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ActionGroup.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  . $PSScriptRoot/../../Public/Confirm-Account.ps1
  Import-Module Az
}

Describe "Confirm-Account" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzContext{}
    }

    It "Calls Get-AzContext" {
      Confirm-Account
      Should -Invoke -CommandName "Get-AzContext" -Times 1
    }

    It "Gets error when environment variables not set" {
      $env:AZ_USE_MANAGED_IDENTITY = $false
      $env:AZ_SUBSCRIPTION_ID = ""
      $env:AZ_TENANT_ID = ""
      $env:AZ_APPLICATION_ID = ""
      $env:AZ_ENCRYPTED_PASSWORD = ""

      $result = Confirm-Account

      $result.Success | Should -Be $false
      $result.AuthenticationData | Should -Be $null
      $result.ResourceDetails | Should -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
