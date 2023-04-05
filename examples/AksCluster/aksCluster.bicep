param aksName string = 'aks${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-09-01' = {
  name: aksName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: '${aksName}-dns'
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

param agentPoolName string = 'ap${take(uniqueString(resourceGroup().id), 5)}'

resource agentPool 'Microsoft.ContainerService/managedClusters/agentPools@2022-09-01' = {
  name: agentPoolName
  parent: aksCluster
  properties: {
    availabilityZones: []
    enableAutoScaling: false
    count: 1
    mode: 'User'
    osType: 'Linux'
    vmSize: 'Standard_B4ms'
  }
}
