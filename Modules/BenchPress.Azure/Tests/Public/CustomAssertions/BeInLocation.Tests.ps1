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

    It "Should not be in location eastus" {
      $mockResource = [PSCustomObject]@{
        Location = 'westus3'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInLocation 'eastus'
    }

    It "Should be false if ConfirmResult is null" {
      $null | Should -Not -BeInLocation 'eastus'
    }
  }
}
