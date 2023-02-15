BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/Bicep.psm1
}

Describe "Confirm-BicepFile" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Bicep Invoke-Command{}
      Mock -ModuleName Bicep Write-Error{}
    }

    It "Calls Invoke-Command when path provided as first parameter without parameter name" {
      Confirm-BicepFile "./nothing.bicep"
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command with path provided as the -BicepFilePath" {
      Confirm-BicepFile -BicepFilePath "./nothing.bicep"
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command with path piped to cmdlet" {
      "./nothing.bicep" | Confirm-BicepFile
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command multiple times with an array of paths provided as first parameter without parameter name" {
      Confirm-BicepFile  "./nothing.bicep","./stillnothing.bicep"
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Invoke-Command multiple times with an array of paths provided as -BicepFilePath" {
      Confirm-BicepFile -BicepFilePath "./nothing.bicep","./stillnothing.bicep"
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Invoke-Command multiple times with an array of paths piped to cmdlet" {
      "./nothing.bicep","./stillnothing.bicep" | Confirm-BicepFile
      Should -Invoke -ModuleName Bicep -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Write-Error when the results have an error" {
      $mockError = New-MockObject -Type 'System.Management.Automation.ErrorRecord'
      Mock -ModuleName Bicep Invoke-Command{ $results = [System.Collections.ArrayList]::new()
                                             $results.Add($mockError)
                                             return $results }
      Confirm-BicepFile "./nothing.bicep"
      Should -Invoke -ModuleName Bicep -CommandName "Write-Error" -Times 2
    }
  }
}

Describe "Deploy-BicepFeature" {
  Context "unit-test" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Bicep Connect-Account{}
      Mock -ModuleName Bicep New-AzResourceGroupDeployment
      Mock -ModuleName Bicep Remove-Item
    }

    It "Should call New-AzResourceGroupDeployment when there are no errors." {
      Mock -ModuleName Bicep Invoke-Command{}
      Deploy-BicepFeature -BicepPath "./path" -Params @{} -ResourceGroupName "rgn"
      Should -Invoke -ModuleName Bicep -CommandName "New-AzResourceGroupDeployment" -Times 1
    }

    It "Should not call New-AzResourceGroupDeployment when there are errors." {
      $mockError = New-MockObject -Type 'System.Management.Automation.ErrorRecord'
      Mock -ModuleName Bicep Invoke-Command{ $results = [System.Collections.ArrayList]::new()
                                             $results.Add($mockError)
                                             return $results }
      Deploy-BicepFeature -BicepPath "./path" -Params @{} -ResourceGroupName "rgn"
      Should -Not -Invoke -ModuleName Bicep -CommandName "New-AzResourceGroupDeployment"
    }
  }
}

Describe "Remove-BicepFeature" {
  Context "unit-test" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Bicep Connect-Account{}
      Mock -ModuleName Bicep Get-AzResourceGroup { "Resource" }
      Mock -ModuleName Bicep Remove-AzResourceGroup {}
    }

    It "Calls Get-AzResourceGroup with the passed in ResourceGroupName" {
      $resourceGroupName = "rgn"
      Remove-BicepFeature -ResourceGroupName $resourceGroupName
      Should -Invoke -ModuleName Bicep -CommandName "Get-AzResourceGroup" `
        -ParameterFilter { $name -eq $resourceGroupName } -Times 1
    }

    It "Calls Remove-AzResourceGroup with the returned resource group name" {
      $resourceGroupName = "rgn"
      Remove-BicepFeature -ResourceGroupName $resourceGroupName
      Should -Invoke -ModuleName Bicep -CommandName "Remove-AzResourceGroup" `
        -ParameterFilter { $name -eq $resourceGroupName } -Times 1
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module Bicep
}
