param location string = resourceGroup().location
param suffix string

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: join( ['benchpress', 'application', 'insights', suffix ], '-')
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
  tags: {
    application: 'benchpress-demo'
    suffix: suffix
  }
}

resource emailActionGroup 'Microsoft.Insights/actionGroups@2022-06-01' = {
  name: join( ['benchpress', 'email', 'action', 'group', suffix ], '-')
  location: 'global'
  properties: {
    groupShortName: 'string'
    enabled: true
    emailReceivers: [
      {
        name: 'Example'
        emailAddress: 'example@test.com'
        useCommonAlertSchema: true
      }
    ]
  }
  tags: {
    application: 'benchpress-demo'
  }
}

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: join( ['benchpress', 'hosting', 'plan', suffix ], '-')
  location: location
  sku: {
    tier: 'Standard'
    name: 'S1'
  }
  tags: {
    application: 'benchpress-demo'
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: join( ['benchpress', 'web', suffix ], '-')
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'Recommended'
        }
      ]
      alwaysOn: true
      ftpsState: 'FtpsOnly'
    }
    serverFarmId: hostingPlan.id
    httpsOnly: true
  }
  tags: {
    application: 'benchpress-demo'
  }
}
