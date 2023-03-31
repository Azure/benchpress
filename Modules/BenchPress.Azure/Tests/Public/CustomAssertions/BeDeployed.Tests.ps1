using module ./../../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../../Public/CustomAssertions/BeDeployed.ps1
}

Describe "ShouldBeDeployed" {
  Context "unit tests" -Tag "Unit" {
    It "Should be deployed with a ConfirmResult object" {
      $mockResource = [PSCustomObject]@{
        Name = 'mockValue'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeDeployed
    }
  }

  It "Should fail if ConfirmResult is null" {
    { $null | Should -BeDeployed } | Should -Throw -ErrorId 'PesterAssertionFailed'
  }
}
