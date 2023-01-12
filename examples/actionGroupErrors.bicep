/*
  This file will throw two errors during bicep build. One for unused parameter and the other for hard coding the
  location.
*/
param actionGroupName string = 'sample action group'
param location string = resourceGroup().location

var actionGroupEmail = 'sampleactiongroup@contoso.com'

resource supportTeamActionGroup 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: actionGroupName
  location: 'westus'
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
