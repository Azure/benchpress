BeforeAll {
  . $PSScriptRoot/../../Public/Deploy-BicepFeature.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
}

Describe "Deploy-BicepFeature" {
  Context "unit-test" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock New-AzResourceGroupDeployment
      Mock Remove-Item
    }

    It "Should call New-AzResourceGroupDeployment when there are no errors." {
      Mock Invoke-Command{}
      Deploy-BicepFeature -BicepPath "./path" -Params @{} -ResourceGroupName "rgn"
      Should -Invoke -CommandName "New-AzResourceGroupDeployment" -Times 1
    }

    It "Should not call New-AzResourceGroupDeployment when there are errors." {
      $mockError = New-MockObject -Type 'System.Management.Automation.ErrorRecord'
      Mock Invoke-Command{ $results = [System.Collections.ArrayList]::new()
                                             $results.Add($mockError)
                                             return $results }
      Deploy-BicepFeature -BicepPath "./path" -Params @{} -ResourceGroupName "rgn"
      Should -Not -Invoke -CommandName "New-AzResourceGroupDeployment"
    }
  }
}

AfterAll {
}
