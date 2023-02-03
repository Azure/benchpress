BeforeAll {
  Import-Module $PSScriptRoot/ActionGroup.psm1
  Import-Module Az
}

Describe "Get-ActionGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ActionGroup Get-AzActionGroup{}
    }

    It "Calls Get-AzActionGroup" {
      Get-ActionGroup -ActionGroupName "agn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ActionGroup -CommandName "Get-AzActionGroup" -Times 1
    }
  }
}

Describe "Get-ActionGroupExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ActionGroup Get-ActionGroup{}
    }

    It "Calls Get-ActionGroup" {
      Get-ActionGroupExist -ActionGroupName "agn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ActionGroup -CommandName "Get-ActionGroup" -Times 1
    }
  }
}

AfterAll {
  Remove-Module ActionGroup
}



