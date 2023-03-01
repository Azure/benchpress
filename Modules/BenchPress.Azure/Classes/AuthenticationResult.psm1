# INLINE_SKIP
using module ./AuthenticationData.psm1
# end INLINE_SKIP

class AuthenticationResult {
  [boolean]$Success
  [System.Management.Automation.ErrorRecord]$Error
  [AuthenticationData]$AuthenticationData
}
