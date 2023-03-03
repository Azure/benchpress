# INLINE_SKIP
using module ./AuthenticationData.psm1
# end INLINE_SKIP

class ConfirmResult {
  [boolean]$Success = $false
  [System.Object]$ResourceDetails
  [AuthenticationData]$AuthenticationData

  ConfirmResult([System.Object]$Resource, [AuthenticationData]$AuthenticationData) {
    $this.Success = -not $null -eq $Resource
    $this.ResourceDetails = $Resource
    $this.AuthenticationData = $AuthenticationData
  }

  ConfirmResult([AuthenticationData]$AuthenticationData) {
    $this.AuthenticationData = $AuthenticationData
  }
}
