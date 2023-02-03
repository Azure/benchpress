BeforeAll {
  Import-Module $PSScriptRoot/AKSCluster.psm1
  Import-Module Az
}

Describe "Get-AKSCluster" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AKSCluster Get-AzAKSCluster{}
    }

    It "Calls Get-AzAKSCluster" {
      Get-AKSCluster -AKSName "acn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AKSCluster -CommandName "Get-AzAKSCluster" -Times 1
    }
  }
}

Describe "Get-AKSClusterExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AKSCluster Get-AKSCluster{}
    }

    It "Calls Get-AKSCluster" {
      Get-AKSClusterExist -AKSName "acn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AKSCluster -CommandName "Get-AKSCluster" -Times 1
    }
  }
}

AfterAll {
  Remove-Module AKSCluster
}


