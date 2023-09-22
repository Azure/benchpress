
param location string = resourceGroup().location
param appserviceplanName string = 'asp${take(uniqueString(resourceGroup().id), 5)}'
param webappName string = 'webapp${take(uniqueString(resourceGroup().id), 5)}'
param staticwebappName string = 'staticwebapp${take(uniqueString(resourceGroup().id), 5)}'

resource appserviceplan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appserviceplanName
  location: location
  tags: {
    displayName: 'HostingPlan'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: join( [webappName, 'application', 'insights'], '-')
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource website 'Microsoft.Web/sites@2022-03-01' = {
  name: webappName
  location: location
  tags: {
    'hidden-related:${appserviceplan.id}': 'empty'
    displayName: 'Website'
  }
  properties: {
    serverFarmId: appserviceplan.id
  }

  resource configAppSettings 'config' = {
    name: 'appsettings'
    properties:{
      APPINSIGHTS_INSTRUMENTATIONKEY: applicationInsights.properties.InstrumentationKey
      APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.properties.ConnectionString
    }
  }
}

resource staticwebsite 'Microsoft.Web/staticSites@2022-03-01' = {
  name: staticwebappName
  location: location
  tags: {
    'hidden-related:${appserviceplan.id}': 'empty'
    displayName: 'Website'
  }
  sku: {
    tier: 'Free'
    name: 'Free'
  }
  properties: {
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'None'
    enterpriseGradeCdnStatus: 'Disabled'
  }
}
