param location string = resourceGroup().location
@secure()
param adminPassword string
param name string = 'psql${take(uniqueString(subscription().id), 5)}'

resource symbolicname 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard_D4ds_v4'
    tier: 'GeneralPurpose'
  }
  properties: {
    version: '12'
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: adminPassword
    network: {
      delegatedSubnetResourceId: (null)
      privateDnsZoneArmResourceId: (null)
    }
    highAvailability: {
      mode: 'ZoneRedundant'
    }
    storage: {
      storageSizeGB: 128
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    availabilityZone: '1'
  }
}
