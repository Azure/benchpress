# INLINE_SKIP
using module ./AuthenticationData.psm1
# end INLINE_SKIP

class AuthenticationResult {
  [boolean]$Success
  [AuthenticationData]$AuthenticationData
}
