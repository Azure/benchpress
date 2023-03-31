using module ./../../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../../Public/CustomAssertions/BeSuccessful.ps1
}

Describe "ShouldBeSuccessful" {
  Context "unit tests" -Tag "Unit" {
    It "Should be deployed with a ConfirmResult object" {
      $mockResource = [PSCustomObject]@{
        Name = 'mockValue'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeSuccessful
    }
  }

  It "Should fail if ConfirmResult is null" {
    { $null | Should -BeSuccessful } | Should -Throw -ErrorId 'PesterAssertionFailed'
  }
}
