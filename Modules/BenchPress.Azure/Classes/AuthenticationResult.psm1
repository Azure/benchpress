using module ./AuthenticationData.psm1

class AuthenticationResult {
  [boolean]$Success
  [System.Management.Automation.ErrorRecord]$Error
  [AuthenticationData]$AuthenticationData
}
