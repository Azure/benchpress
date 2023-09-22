param location string = 'westus3'
@secure()
param vmAdminPasswordOrKey string

module virtualmachine '../VirtualMachine/virtualMachine.bicep' = {
  name: 'virtual_machine'
  params: {
    location: location
    adminPasswordOrKey: vmAdminPasswordOrKey
  }
}
