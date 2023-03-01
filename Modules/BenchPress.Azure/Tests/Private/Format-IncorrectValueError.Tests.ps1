BeforeAll {
  . $PSScriptRoot/../../Private/Format-ErrorRecord.ps1
  . $PSScriptRoot/../../Private/Format-IncorrectValueError.ps1
}

Describe "Format-IncorrectValueError" {
  Context "unit tests" -Tag "Unit" {
    It "Calls Format-ErrorRecord when Format-IncorrectValueError is called" {
      Mock Format-ErrorRecord{} -Verifiable
      Format-IncorrectValueError -Message "testMessage"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
}
