param location string
param name string

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Basic_A0'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
  }
}
