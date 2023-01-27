param location string = resourceGroup().location
param name string = 'vmtest1'

resource vm 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS2_v2'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    // networkProfile: {
    //   networkInterfaces: [
    //     {
    //       id: //nic.id
    //     }
    //   ]
    // }
  }
}
