BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-WebApp.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-WebApp" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzWebApp" {
      Mock Get-AzWebApp{}
      Confirm-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzWebApp" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzWebApp{ throw [Exception]::new("Exception") }
      $Results = Confirm-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
