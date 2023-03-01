param actionGroupName string = 'ag${take(uniqueString(resourceGroup().id), 5)}'
param location string = 'global'

var actionGroupEmail = 'sampleactiongroup@contoso.com'

resource supportTeamActionGroup 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: actionGroupName
  location: location
  properties: {
    enabled: true
    groupShortName: actionGroupName
    emailReceivers: [
      {
        name: actionGroupName
        emailAddress: actionGroupEmail
        useCommonAlertSchema: true
      }
    ]
  }
}
