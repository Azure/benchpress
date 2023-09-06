function Get-EnvironmentVariable {
  <#
    .SYNOPSIS
      Get-EnvironmentVariable is a private helper method that retrieves environment variables.

    .DESCRIPTION
      Get-EnvironmentVariable retrieves the environment variable specified by the input parameter.

    .PARAMETER VariableName
      This is the name of the environment variable to retrieve and validate that a value is present.

    .EXAMPLE
      Provide -VariableName Parameter.

      Get-EnvironmentVariable -VariableName AZ_APPLICATION_ID

    .EXAMPLE
      Provide variable name without -VariableName Parameter.

      Get-EnvironmentVariable AZ_APPLICATION_ID

    .INPUTS
      System.String

    .OUTPUTS
      System.String
  #>
  [OutputType([System.String])]
  param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$VariableName
  )
  Begin {
    $value = [string]$null
  }
  Process {
    $value = [System.Environment]::GetEnvironmentVariable($VariableName)
  }
  End {
    $value
  }
}
