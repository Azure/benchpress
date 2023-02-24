BeforeAll {
  . $PSScriptRoot/../../Private/Format-ErrorRecord.ps1
  . $PSScriptRoot/../../Private/Format-NotExistError.ps1
}

Describe "Format-NotExistError" {
  Context "unit tests" -Tag "Unit" {
    It "Calls Format-ErrorRecord when Format-NotExistError is called" {
      Mock Format-ErrorRecord{} -Verifiable
      Format-NotExistError -Message "testMessage"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
}
