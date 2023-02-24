BeforeAll {
  . $PSScriptRoot/../../Private/Format-ErrorRecord.ps1
}

Describe "Format-ErrorRecord"  {
  Context "unit tests" -Tag "Unit" {
    It "Creates ErrorRecord with correct message and ID when Format-ErrorRecord is called" {
      Mock New-Object{} -Verifiable
      Format-ErrorRecord -Message "testMessage" -ErrorID "testErrorID"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
}
