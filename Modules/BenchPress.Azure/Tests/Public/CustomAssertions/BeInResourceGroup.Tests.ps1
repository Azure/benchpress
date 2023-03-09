using module ./../../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../../Public/CustomAssertions/BeInResourceGroup.ps1
}

Describe "ShouldBeInResourceGroup" {
  Context "unit tests" -Tag "Unit" {
    It "Should be in resource group testrg with 'ResourceGroupName' property" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = 'testrg'
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -BeInResourceGroup 'testrg'
    }

    It "Should be in resource group testrg with 'ResourceGroup' property" {
      $mockResource = [PSCustomObject]@{
        ResourceGroup = 'testrg'
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

    It "Should be false if ResourceGroupName property is empty" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = ''
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should be false if ResourceGroup property is empty" {
      $mockResource = [PSCustomObject]@{
        ResourceGroup = ''
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      $result | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should fail if ConfirmResult is null " {
      { $null | Should -BeInResourceGroup 'testrg' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if ConfirmResult is null with '-Not'" {
      { $null | Should -Not -BeInResourceGroup 'fakerg' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if ResourceGroupName or ResourceGroup empty" {
      $mockResource = [PSCustomObject]@{
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      { $result | Should -BeInResourceGroup 'fakerg' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if if ResourceGroupName or ResourceGroup empty with '-Not'" {
      $mockResource = [PSCustomObject]@{
      }
      $result = [ConfirmResult]::new($mockResource, $null)
      { $result | Should -Not -BeInResourceGroup 'fakerg' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }
  }
}
