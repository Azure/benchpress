using module ./AuthenticationData.psm1

class ConfirmResult {
  [boolean]$Success
  [System.Object]$ResourceDetails
  [AuthenticationData]$AuthenticationData
  [System.Management.Automation.ErrorRecord]$ErrorRecord

  ConfirmResult([System.Object]$Resource, [AuthenticationData]$AuthenticationData) {
    $this.Success = -not $null -eq $Resource
    $this.ResourceDetails = $Resource
    $this.AuthenticationData = $AuthenticationData
  }

  ConfirmResult([System.Management.Automation.ErrorRecord]$ErrorRecord, [AuthenticationData]$AuthenticationData) {
    $this.Success = $false
    $this.ErrorRecord = $ErrorRecord
    $this.AuthenticationData = $AuthenticationData
  }
}
