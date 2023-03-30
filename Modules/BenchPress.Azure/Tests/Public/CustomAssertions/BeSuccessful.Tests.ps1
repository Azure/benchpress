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
    # TODO: Should we keep these null examples? Adding cmldet binding to the function now throws
    # a validation error if the parameter is null
    # Don't know if we even need the null check now in BeSuccessful.ps1
    # Could also do a try/catch and throw a custom error ('PesterAssertionFailed')
    { $null | Should -BeSuccessful } | Should -Throw -ErrorId 'ParameterArgumentValidationErrorNullNotAllowed,Invoke-Assertion'
  }
}
