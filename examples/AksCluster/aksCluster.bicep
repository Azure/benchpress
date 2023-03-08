param name string = 'aks${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-09-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: '${name}-dns'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: 30
        count: 1
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
  }
}
