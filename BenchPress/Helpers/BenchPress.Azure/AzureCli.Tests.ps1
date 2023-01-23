BeforeAll {
  Import-Module $PSScriptRoot/AzureCli.psm1
}

Describe "Invoke-AzCli" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AzureCli Write-Error{}
    }

    It "Calls Invoke-Expression" {
      Mock -ModuleName AzureCli Invoke-Expression{ return 0 }

      Invoke-AzCli -Command "command"
      Should -Invoke -ModuleName AzureCli -CommandName "Invoke-Expression" -Times 1
      Should -Not -Invoke -ModuleName AzureCli -CommandName "Write-Error"
    }

    It "Calls Write-Error when the error code is greater than 0" {
      Mock -ModuleName AzureCli Invoke-Expression{ return 1 }
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
  Remove-Module AzureCli
}
