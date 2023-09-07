

BeforeAll {
  . $PSScriptRoot/../../Private/Get-RequiredEnvironmentVariable.ps1
  Import-Module Az

  $environmentVariableName = "__BP_Test_Env_var__"
  $environmentVariableValue = "1234"
  [System.Environment]::SetEnvironmentVariable($environmentVariableName, $environmentVariableValue)
}


Describe "Connect-Account" {
  Context "unit tests" -Tag "Unit" {
    It "Throws an error when the environment variable is not set" {
      # Arrange
      $fakeEnvironmentVariableName="__BP_Does_Not_Exist__"

      # Act
      $operation = { Get-RequiredEnvironmentVariable $fakeEnvironmentVariableName }

      # Assert
      $operation | Should -Throw "Missing Required Environment Variable $fakeEnvironmentVariableName"
    }


    It "Read from an Environment Variable when it is set" {
      # Act
      $result = Get-RequiredEnvironmentVariable $environmentVariableName

      # Assert
      $result | Should -Be $environmentVariableValue
    }
  }
}

AfterAll {
  Remove-Item "Env:\$environmentVariableName"
}
