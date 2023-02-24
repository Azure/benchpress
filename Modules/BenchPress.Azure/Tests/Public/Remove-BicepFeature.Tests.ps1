BeforeAll {
  . $PSScriptRoot/../../Public/Remove-BicepFeature.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1

  Import-Module Az
}

Describe "Remove-BicepFeature" {
  Context "unit-test" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzResourceGroup { "Resource" }
      Mock Remove-AzResourceGroup {}
    }

    It "Calls Get-AzResourceGroup with the passed in ResourceGroupName" {
      $resourceGroupName = "rgn"
      Remove-BicepFeature -ResourceGroupName $resourceGroupName
      Should -Invoke -CommandName "Get-AzResourceGroup" `
        -ParameterFilter { $name -eq $resourceGroupName } -Times 1
    }

    It "Calls Remove-AzResourceGroup with the returned resource group name" {
      $resourceGroupName = "rgn"
      Remove-BicepFeature -ResourceGroupName $resourceGroupName
      Should -Invoke -CommandName "Remove-AzResourceGroup" `
        -ParameterFilter { $name -eq $resourceGroupName } -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
