using module ./../../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../../Public/CustomAssertions/BeSuccessful.ps1
}

Describe "ShouldBeSuccessful" {
  Context "unit tests" -Tag "Unit" {
    It "Should be successful with a ConfirmResult object" {
      $mockResource = [PSCustomObject]@{
        Name = 'mockValue'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeSuccessful
    }

    It "Should not be successful with a negative ConfirmResult object" {
      [ConfirmResult]::new($null, $null) | Should -Not -BeSuccessful
    }

    It "Should fail if ConfirmResult is null" {
      { $null | Should -BeSuccessful } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }
  }
}
