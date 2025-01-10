function Get-EnvironmentVariable {
  <#
    .SYNOPSIS
      Get-EnvironmentVariable is a private helper method that retrieves environment variables with the expectation that by default if they are not present that an error will be thrown. An override switch -DontThrowIfMissing can provided to skip throwing the exception.

    .DESCRIPTION
      Get-EnvironmentVariable retrieves the environment variable specified by the input parameter and checks to be sure that a value is present for that environment variable. If the value is missing or whitespace a error be be thrown unless the -DontThrowIfMissing switch is provided.

    .PARAMETER VariableName
      This is the name of the environment variable to retrieve and validate that a value is present.

    .PARAMETER DontThrowIfMissing
      This is a switch that can be provided to skip throwing an error if the environment variable is missing.

    .EXAMPLE
      Provide -VariableName Parameter.

      Get-RequiredEnvironmentVariable -VariableName AZ_APPLICATION_ID

    .EXAMPLE
      Provide variable name without -VariableName Parameter.

      Get-RequiredEnvironmentVariable AZ_APPLICATION_ID

    .EXAMPLE
      Provide -DontThrowIfMissing switch.

      Get-RequiredEnvironmentVariable -VariableName AZ_APPLICATION_ID -DontThrowIfMissing

    .INPUTS
      System.String

    .OUTPUTS
      System.String
  #>
  [OutputType([System.String])]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$VariableName,
    [switch]$DontThrowIfMissing
  )
  Begin {
    $value = [string]$null
  }
  Process {
    $value = [System.Environment]::GetEnvironmentVariable($VariableName)

    if (-Not $DontThrowIfMissing -and [string]::IsNullOrWhiteSpace($value)) {
      throw "Missing Required Environment Variable $VariableName"
    }
  }
  End {
    $value
  }
}

function Get-RequiredEnvironmentVariable {
  [OutputType([System.String])]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$VariableName
  )
  Begin {
    $value = [string]$null
  }
  Process {
    $value = Get-EnvironmentVariable $VariableName
  }
  End {
    $value
  }
}


function Get-BooleanEnvironmentVariable {
  [OutputType([System.Boolean])]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$VariableName
  )
  Begin {
    $result = $False
  }
  Process {
    $value = Get-EnvironmentVariable $VariableName -DontThrowIfMissing
    try {
      $result = [System.Convert]::ToBoolean($value)
    } catch [FormatException] {
      $result = $False
    }
  }
  End {
    $result
  }
}
