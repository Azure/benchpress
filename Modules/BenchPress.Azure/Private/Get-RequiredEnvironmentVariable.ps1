function Get-RequiredEnvironmentVariable {
  <#
    .SYNOPSIS
      Get-RequiredEnvironmentVariable is a private helper method that retrieves environment variables with the
      expectation that if they are not present that an error will be logged with an immedate exit.

    .DESCRIPTION
      Get-RequiredEnvironmentVariable retrieves the environment variable specified by the input parameter and checks to
      be sure that a value is present for that environment variable. If the value is missing or whitespace a message
      will be written to Write-Error with the name of the variable in the output and exit will be called.

    .PARAMETER VariableName
      This is the name of the environment variable to retrieve and validate that a value is present.

    .EXAMPLE
      Provide -VariableName Parameter

      Get-RequiredEnvironmentVariable -VariableName AZ_APPLICATION_ID

    .EXAMPLE
      Provide variable name without -VariableName Parameter

      Get-RequiredEnvironmentVariable AZ_APPLICATION_ID

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
    $Value = [string]$null
  }
  Process {
    $Value = [System.Environment]::GetEnvironmentVariable($VariableName)

    if ([string]::IsNullOrWhiteSpace($Value)) {
      Write-Error("Missing Required Environment Variable $VariableName")
      exit 1
    }
  }
  End {
    return $Value
  }
}
