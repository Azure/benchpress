using module ./../../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../../Public/CustomAssertions/BeInLocation.ps1
}

Describe "ShouldBeInLocation" {
  Context "unit tests" -Tag "Unit" {
    It "Should be in location westus3" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus3'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInLocation 'westus3'
    }

    It "Should be in location westus3 despite uppercase" {
      $mockResource = [PSCustomObject]@{
        Location = 'WEST US 3'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInLocation 'westus3'
    }

    It "Should be in location eastus despite uppercase and space" {
      $mockResource = [PSCustomObject]@{
        Location = ' EAST US '
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInLocation 'eastus'
    }

    It "Should be in location westus2 despite uppercase" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus2'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInLocation 'WEST US 2'
    }

    It "Should not be in location eastus" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus3'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInLocation 'eastus'
    }

    It "Should mismatch if location empty" {
      $mockResource = [PSCustomObject]@{
        Location = ''
      }
      [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInLocation 'eastus'
    }

    # TODO: Same issue with Null here
    It "Should fail if ConfirmResult is null" {
      { $null | Should -BeInLocation 'eastus' } | Should -Throw -ErrorId 'ParameterArgumentValidationErrorNullNotAllowed,Invoke-Assertion'
    }

    It "Should fail if ConfirmResult is null with '-Not'" {
      { $null | Should -Not -BeInLocation 'eastus' } | Should -Throw -ErrorId 'ParameterArgumentValidationErrorNullNotAllowed,Invoke-Assertion'
    }

    It "Should fail if location empty" {
      $mockResource = [PSCustomObject]@{}
      { [ConfirmResult]::new($mockResource, $null) | Should -BeInLocation 'eastus' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if location empty with '-Not'" {
      $mockResource = [PSCustomObject]@{}
      { [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInLocation 'eastus' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }
  }
}
