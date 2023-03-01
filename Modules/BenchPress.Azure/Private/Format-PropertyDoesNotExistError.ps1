function Format-PropertyDoesNotExistError([string]$PropertyKey) {
  <#
    .SYNOPSIS
      Private function to create a message and ErrorRecord for when a resource property does not exist.

    .DESCRIPTION
      Format-PropertyDoesNotExistError is a private helper function that can be used to construct a message and
      ErrorRecord for when a resource property does not exist.

    .PARAMETER PropertyKey
      The resource property name that is checked

    .EXAMPLE
      Format-PropertyDoesNotExistError -PropertyKey "Location"

    .INPUTS
      System.String

    .OUTPUTS
      System.Management.Automation.ErrorRecord
  #>
  $Message = "$PropertyKey is not a property on the resource"
  return Format-ErrorRecord -Message $Message -ErrorID "BenchPressPropertyFail"
}
