function Format-ErrorRecord ([string] $Message, [string]$ErrorID) {
  <#
    .SYNOPSIS
      Private function to help construct a ErrorRecord.

    .DESCRIPTION
      Format-ErrorRecord is a private helper function that can be used to construct an ErrorRecord.

    .PARAMETER Message
      Message for the ErrorRecord

    .PARAMETER ErrorID
      A string that can be used to uniquily identify the ErrorRecord.

    .EXAMPLE
      Format-ErrorRecord -Message $incorrectValueMessage -ErrorID "BenchPressValueFail"

    .INPUTS
      System.String

    .OUTPUTS
      System.Management.Automation.ErrorRecord
  #>
  $Exception = [Exception] $Message
  $ErrorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
  $TargetObject = @{ Message = $Message }
  $ErrorRecord = New-Object System.Management.Automation.ErrorRecord $Exception, $ErrorID, $ErrorCategory, $TargetObject
  return $ErrorRecord
}
