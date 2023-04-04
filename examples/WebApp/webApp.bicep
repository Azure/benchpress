
param location string = 'EastUS2'
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
