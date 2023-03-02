param name string = 'kv${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location
param svcPrincipalObjectId string

resource vault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  properties: {
    accessPolicies:[
      {
        tenantId: subscription().tenantId
        objectId: svcPrincipalObjectId
        permissions: {
          secrets: ['get', 'list']
          certificates: ['get', 'list']
          keys: ['get', 'list']
        }
      }
    ]
    enableRbacAuthorization: false
    enableSoftDelete: false
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

resource key 'Microsoft.KeyVault/vaults/keys@2022-07-01' = {
  parent: vault
  name: 'samplekey'
  properties: {
    kty: 'RSA'
    keyOps: []
    keySize: 2048
    curveName: 'P-521'
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: vault
  name: 'samplesecret'
  properties: {
    contentType: 'text/plain'
    value: 'samplevalue'
  }
}
