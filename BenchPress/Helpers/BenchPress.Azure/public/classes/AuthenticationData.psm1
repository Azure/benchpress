class AuthenticationData {
  [string]$SubscriptionId

  AuthenticationData([string]$SubscriptionId) {
    $this.SubscriptionId = $SubscriptionId
  }
}
