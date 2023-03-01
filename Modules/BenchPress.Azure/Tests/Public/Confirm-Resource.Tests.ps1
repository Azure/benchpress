using module ./../../Classes/ConfirmResult.psm1

BeforeAll {
  . $PSScriptRoot/../../Private/Format-ErrorRecord.ps1
  . $PSScriptRoot/../../Private/Format-IncorrectValueError.ps1
  . $PSScriptRoot/../../Private/Format-NotExistError.ps1
  . $PSScriptRoot/../../Private/Format-PropertyDoesNotExistError.ps1

  . $PSScriptRoot/../../Public/Confirm-Resource.ps1
  . $PSScriptRoot/../../Public/Get-ResourceByType.ps1
}

Describe "Confirm-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Format-NotExistError{}
      Mock Format-ErrorRecord{}
      Mock Format-IncorrectValueError{}
      Mock Format-PropertyDoesNotExistError{}
      $script:ConfirmResult = [ConfirmResult]::new(
        @{
          TestKey = "TestValue"
          TestArray = @(@{AnotherKey = "AnotherValue"})
        }, $null)
    }

    It "Calls Get-ResourceByType; returns true when Get-ResourceByType returns a Success ConfirmResult." {
      Mock Get-ResourceByType{ $ConfirmResult }

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when property matches value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "TestValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -CommandName "Format-IncorrectValueError" -Times 0

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when accessing property in array and matches value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -CommandName "Format-IncorrectValueError" -Times 0

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType and Format-Error; returns false when Get-ResourceByType returns empty object." {
      Mock Get-ResourceByType{ return $null } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-ErrorRecord" -Times 1
      Should -Invoke -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-IncorrectValueError; returns false when property does not match value." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "WrongValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -CommandName "Format-IncorrectValueError" -Times 1

      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType; returns false when indexing incorrectly into property array" {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable

      $result.Success | Should -Be $false
      $result.ErrorRecord | Should -Not -Be $null
    }

    It "Calls Get-ResourceByType and Format-PropertyDoesNotExistError; returns false when property does not exist." {
      Mock Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongKey" -PropertyValue "TestValue"

      Should -InvokeVerifiable
      Should -Invoke -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -CommandName "Format-PropertyDoesNotExistError" -Times 1

      $result.Success | Should -Be $false
    }
  }
}

AfterAll {
}
