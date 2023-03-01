using module ./../../../Classes/ConfirmResult.psm1

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

  It "Should not be deployed with a null resource" {
      $result = [ConfirmResult]::new($null, $null)

      $result | Should -Not -BeDeployed
    }
}
