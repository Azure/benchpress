using module ./../../Classes/ConfirmResult.psm1
using module ./../../Classes/ResourceType.psm1

BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-Resource.ps1
}

Describe "Confirm-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Write-Error{ }
      $script:ConfirmResult = [ConfirmResult]::new(
        [PSCustomObject]@{
          TestKey   = "TestValue"
          TestArray = @([PSCustomObject]@{AnotherKey = "AnotherValue"})
          TestObject = [PSCustomObject]@()
        }, $null)
    }

    It "Calls Get-ResourceByType; returns true when Get-ResourceByType returns a Success ConfirmResult." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Write-Error" -Times 0
      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when property matches value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "TestValue"

      Should -InvokeVerifiable
      Should -Not -Invoke -CommandName "Write-Error"

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when accessing property in array and matches value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable
      Should -Not -Invoke -CommandName "Write-Error"

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType and Format-Error; returns false when Get-ResourceByType returns empty object." {
      Mock Get-ResourceByType{ return $null } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Write-Error" -Times 1
      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-IncorrectValueError; returns false when property does not match value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "WrongValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Write-Error" -Times 1

      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType; returns false when indexing incorrectly into property array" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable

      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-PropertyDoesNotExistError; returns false when property does not exist." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongKey" -PropertyValue "TestValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Write-Error" -Times 1

      $result.Success | Should -Be $false
    }

    It "Calls Write-Error when attempting to access an index of an object that does not implement the IList interface" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $params = @{
        ResourceType = "ResourceGroup"
        ResourceName = "mockResourceName"
        PropertyKey  = "TestKey[0]"
      }

      $result = Confirm-Resource @params

      Should -Invoke -CommandName "Write-Error" -Times 1
      $result.Success | Should -Be $false
    }

    It "Calls Write-Error when the index is out of range for an IList path" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $params = @{
        ResourceType = "ResourceGroup"
        ResourceName = "mockResourceName"
        PropertyKey  = "TestArray[1]"
      }

      $result = Confirm-Resource @params

      Should -Invoke -CommandName "Write-Error" -Times 1
      $result.Success | Should -Be $false
    }

    It "Calls Write-Error when the index is is less than zero" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $params = @{
        ResourceType = "ResourceGroup"
        ResourceName = "mockResourceName"
        PropertyKey  = "TestArray[-1]"
      }

      $result = Confirm-Resource @params

      Should -Invoke -CommandName "Write-Error" -Times 1
      $result.Success | Should -Be $false
    }

    It "Calls Write-Error when the path has a key that is not present" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable -RemoveParameterType 'ResourceType'

      $params = @{
        ResourceType = "ResourceGroup"
        ResourceName = "mockResourceName"
        PropertyKey  = "TestObject.NoKey"
      }

      $result = Confirm-Resource @params

      Should -Invoke -CommandName "Write-Error" -Times 1
      $result.Success | Should -Be $false
    }
  }
}

AfterAll {
}
