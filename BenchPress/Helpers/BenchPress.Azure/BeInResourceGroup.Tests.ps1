using module ./public/classes/ConfirmResult.psm1

Describe "ShouldBeInResourceGroup" {
  Context "unit tests" -Tag "Unit" {
    It "Should be in resource group testrg" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = 'testrg'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInResourceGroup 'testrg'
    }

    It "Should not be in resource group fakerg" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = 'testrg'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should be false if ConfirmResult is null" {
      $null | Should -Not -BeInResourceGroup 'testrg'
    }
  }
}
