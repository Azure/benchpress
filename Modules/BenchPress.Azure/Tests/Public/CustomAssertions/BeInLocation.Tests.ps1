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
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInLocation 'westus3'
    }

    It "Should be in location westus3 despite uppercase" {
      $mockResource = [PSCustomObject]@{
        Location = 'WEST US 3'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInLocation 'westus3'
    }

    It "Should be in location eastus despite uppercase and space" {
      $mockResource = [PSCustomObject]@{
        Location = ' EAST US '
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInLocation 'eastus'
    }

    It "Should be in location westus2 despite uppercase" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus2'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInLocation 'WEST US 2'
    }

    It "Should not be in location eastus" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus3'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInLocation 'eastus'
    }

    It "Should mismatch if location empty" {
      $mockResource = [PSCustomObject]@{
        Location = ''
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInLocation 'eastus'
    }

    It "Should fail if ConfirmResult is null" {
      { $null | Should -BeInLocation 'eastus' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if ConfirmResult is null with '-Not'" {
      { $null | Should -Not -BeInLocation 'eastus' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if location empty" {
      $mockResource = [PSCustomObject]@{
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      { $result | Should -BeInLocation 'eastus' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if location empty with '-Not'" {
      $mockResource = [PSCustomObject]@{
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      { $result | Should -Not -BeInLocation 'eastus' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }
  }
}
