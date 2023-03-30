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
      [ConfirmResult]::new($mockResource, $null) | Should -BeInResourceGroup 'testrg'
    }

    It "Should be in resource group testrg with 'ResourceGroup' property" {
      $mockResource = [PSCustomObject]@{
        ResourceGroup = 'testrg'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInResourceGroup 'testrg'
    }

    It "Should not be in resource group fakerg" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = 'testrg'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should be false if ResourceGroupName property is empty" {
      $mockResource = [PSCustomObject]@{
        ResourceGroupName = ''
      }
      [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should be false if ResourceGroup property is empty" {
      $mockResource = [PSCustomObject]@{
        ResourceGroup = ''
      }
      [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInResourceGroup 'fakerg'
    }

    It "Should be true if Id exists" {
      $mockResource = [PSCustomObject]@{
        Id = '/subscriptions/8274ddsad-12318/resourceGroups/fakerg/providers/Microsoft.Synapse/workspaces/fakerg'
      }
      [ConfirmResult]::new($mockResource, $null) | Should -BeInResourceGroup 'fakerg'
    }

    # TODO: Null Tests here too
    It "Should fail if ConfirmResult is null " {
      { $null | Should -BeInResourceGroup 'testrg' } | Should -Throw -ErrorId 'ParameterArgumentValidationErrorNullNotAllowed,Invoke-Assertion'
    }

    It "Should fail if ConfirmResult is null with '-Not'" {
      { $null | Should -Not -BeInResourceGroup 'fakerg' } | Should -Throw -ErrorId 'ParameterArgumentValidationErrorNullNotAllowed,Invoke-Assertion'
    }

    It "Should fail if ResourceGroupName or ResourceGroup empty" {
      $mockResource = [PSCustomObject]@{}
      { [ConfirmResult]::new($mockResource, $null)| Should -BeInResourceGroup 'fakerg' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if ResourceGroupName or ResourceGroup empty with '-Not'" {
      $mockResource = [PSCustomObject]@{}
      { [ConfirmResult]::new($mockResource, $null)| Should -Not -BeInResourceGroup 'fakerg' }  | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if Id is the wrong format" {
      $mockResource = [PSCustomObject]@{
        Id = 'https://myvault.vault.azure.net/keys/my-key/version'
      }
      { [ConfirmResult]::new($mockResource, $null) | Should -BeInResourceGroup 'fakerg' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }

    It "Should fail if Id is the wrong format with '-Not'" {
      $mockResource = [PSCustomObject]@{
        Id = 'https://myvault.vault.azure.net/keys/my-key/version'
      }
      { [ConfirmResult]::new($mockResource, $null) | Should -Not -BeInResourceGroup 'fakerg' } | Should -Throw -ErrorId 'PesterAssertionFailed'
    }
  }
}
