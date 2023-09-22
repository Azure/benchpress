param serviceName string = 'apim${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location

resource apiManagementService 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: serviceName
  location: location
  sku: {
    capacity: 1
    name: 'Developer'
  }
  properties: {
    publisherEmail: 'email@contoso.com'
    publisherName: 'Contoso'
  }
}

param apiName string = 'api${take(uniqueString(resourceGroup().id), 5)}'

resource api 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: apiName
  parent: apiManagementService
  properties: {
    displayName: apiName
    path: '/'
    protocols: ['https']
  }
}

param workspaceName string = 'logworkspace${take(uniqueString(resourceGroup().id), 5)}'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

param appInsightsName string = 'appinsights${take(uniqueString(resourceGroup().id), 5)}'

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
}

param loggerName string = 'log${take(uniqueString(resourceGroup().id), 5)}'

resource logger 'Microsoft.ApiManagement/service/loggers@2022-08-01' = {
  name: loggerName
  parent: apiManagementService
  properties: {
    credentials: {
      instrumentationKey: applicationInsights.properties.InstrumentationKey
    }
    loggerType: 'applicationInsights'
  }
}

param diagnosticName string = 'applicationinsights'

resource diagnostic 'Microsoft.ApiManagement/service/diagnostics@2022-08-01' = {
  name: diagnosticName
  parent: apiManagementService
  properties: {
    loggerId: logger.id
  }
}

param policyName string = 'policy'

resource apiPolicy 'Microsoft.ApiManagement/service/apis/policies@2022-08-01' = {
  name: policyName
  parent: api
  properties: {
    format: 'rawxml'
    value: loadTextContent('./ApiManagementPolicy.xml')
  }
}
