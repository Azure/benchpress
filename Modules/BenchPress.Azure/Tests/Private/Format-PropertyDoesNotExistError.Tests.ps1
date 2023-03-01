BeforeAll {
  . $PSScriptRoot/../../Private/Format-ErrorRecord.ps1
  . $PSScriptRoot/../../Private/Format-PropertyDoesNotExistError.ps1
}

Describe "Format-PropertyDoesNotExistError" {
  Context "unit tests" -Tag "Unit" {
    It "Calls Format-ErrorRecord when Format-PropertyDoesNotExistError is called" {
      Mock Format-ErrorRecord{} -Verifiable
      Format-PropertyDoesNotExistError -PropertyKey "testKey"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
}
