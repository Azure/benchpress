BeforeAll {
  . $PSScriptRoot/../../Public/Get-Resource.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1

  Import-Module Az
}

Describe "Get-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzResource{}
    }

    It "Calls Get-AzResource without -ResourceGroupName parameter when not provided." {
      Get-Resource -ResourceName "rn"
      Should -Invoke -CommandName Get-AzResource -ParameterFilter { $name -eq "rn"; $resourceGroupName -eq $null }
    }

    It "Calls Get-AzResource with -ResourceGroupName parameter when provided." {
      Get-Resource -ResourceName "rn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName Get-AzResource -ParameterFilter { $name -eq "rn"; $resourceGroupName -eq "rgn" }
    }
  }
}

AfterAll {
  Remove-Module Az
}
