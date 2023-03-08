BeforeAll {
  . $PSScriptRoot/../../Public/Invoke-AzCli.ps1
}

Describe "Invoke-AzCli" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Write-Error{}
      $Global:LASTEXITCODE = 0
    }

    It "Calls Invoke-Expression" {
      Mock Invoke-Expression{ }

      Invoke-AzCli -Command "command"
      Should -Invoke -CommandName "Invoke-Expression" -Times 1
      Should -Not -Invoke -CommandName "Write-Error"
    }

    It "Calls Write-Error when the error code is greater than 0" {
      Mock Invoke-Expression{ $Global:LASTEXITCODE = 1 }

      Invoke-AzCli -Command "command"
      Should -InvokeVerifiable
    }

    AfterEach {
      # Reset the $LastExitCode
      $Global:LASTEXITCODE = 0
    }
  }
}

AfterAll {
}
