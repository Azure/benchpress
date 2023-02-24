BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-BicepFile.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
}

Describe "Confirm-BicepFile" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Invoke-Command{}
      Mock Write-Error{}
    }

    It "Calls Invoke-Command when path provided as first parameter without parameter name" {
      Confirm-BicepFile "./nothing.bicep"
      Should -Invoke -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command with path provided as the -BicepFilePath" {
      Confirm-BicepFile -BicepFilePath "./nothing.bicep"
      Should -Invoke -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command with path piped to cmdlet" {
      "./nothing.bicep" | Confirm-BicepFile
      Should -Invoke -CommandName "Invoke-Command"  -Times 1
    }

    It "Calls Invoke-Command multiple times with an array of paths provided as first parameter without parameter name" {
      Confirm-BicepFile  "./nothing.bicep","./stillnothing.bicep"
      Should -Invoke -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Invoke-Command multiple times with an array of paths provided as -BicepFilePath" {
      Confirm-BicepFile -BicepFilePath "./nothing.bicep","./stillnothing.bicep"
      Should -Invoke -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Invoke-Command multiple times with an array of paths piped to cmdlet" {
      "./nothing.bicep","./stillnothing.bicep" | Confirm-BicepFile
      Should -Invoke -CommandName "Invoke-Command"  -Times 2
    }

    It "Calls Write-Error when the results have an error" {
      $mockError = New-MockObject -Type 'System.Management.Automation.ErrorRecord'
      Mock Invoke-Command{ $results = [System.Collections.ArrayList]::new()
                                             $results.Add($mockError)
                                             return $results }
      Confirm-BicepFile "./nothing.bicep"
      Should -Invoke -CommandName "Write-Error" -Times 2
    }
  }
}

AfterAll {
}
