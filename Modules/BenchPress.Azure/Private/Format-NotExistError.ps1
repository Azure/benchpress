function Format-NotExistError([string]$Expected) {
  <#
    .SYNOPSIS
      Private function to create a message and ErrorRecord for when a resource does not exist.

    .DESCRIPTION
      Format-NotExistError is a private helper function that can be used to construct a message and ErrorRecord
      for when a resource does not exist.

    .PARAMETER Expected
      The name of the resource that was expected to exist.

    .EXAMPLE
      Format-NotExistError -Expected "MyVM"

    .INPUTS
      System.String

    .OUTPUTS
      System.Management.Automation.ErrorRecord
  #>
  $Message = "Expected $Expected to exist, but it does not exist."
  return Format-ErrorRecord -Message $Message -ErrorID "BenchPressExistFail"
}
