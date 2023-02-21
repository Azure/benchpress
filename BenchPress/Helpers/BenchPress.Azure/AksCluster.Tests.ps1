using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/AksCluster.psm1
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module Az
}

Describe "Get-AksCluster" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AksCluster Connect-Account{}
    }

    It "Calls Get-AzAksCluster" {
      Mock -ModuleName AksCluster Get-AzAksCluster{}
      Confirm-AksCluster -AksName "acn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AksCluster -CommandName "Get-AzAksCluster" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName AksCluster Get-AzAksCluster{ throw [Exception]::new("Exception") }
      $Results = Confirm-AksCluster -AksName "acn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module AksCluster
  Remove-Module Authentication
  Remove-Module Az
}
