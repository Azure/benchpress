function Format-IncorrectValueError([string]$ExpectedKey, [string]$ExpectedValue, [string]$ActualValue) {
  <#
    .SYNOPSIS
      Private function to create a message and ErrorRecord for when a resource property is not set correctly.

    .DESCRIPTION
      Format-IncorrectValueError is a private helper function that can be used to construct a message and ErrorRecord
      for when a resource property is not set to the expected value.

    .PARAMETER ExpectedKey
      The resource property name that is checked

    .PARAMETER ExpectedValue
      The expected value of the resource property

    .PARAMETER ActualValue
      The actual value of the resource property

    .EXAMPLE
      Format-IncorrectValueError -ExpectedKey "Location" -ExpectedValue "WestUS3" -ActualValue "EastUS"

    .INPUTS
      System.String

    .OUTPUTS
      System.Management.Automation.ErrorRecord
   #>
  $Message = "Expected $ExpectedKey to be $ExpectedValue, but got $ActualValue"
  return Format-ErrorRecord -Message $Message -ErrorID "BenchPressValueFail"
}
