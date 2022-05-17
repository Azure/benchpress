BeforeAll{
    . $PSScriptRoot/BenchPress/Helpers/Azure/ResourceGroup.ps1
}
Describe 'Verify Resource Group Exists' {
    it 'Should contain a resource group named tflintrules' {
        #arrange
        $rgName = "tflintrules"

        #act
        $exists = Get-ResourceGroupExists($rgName)

        #assert
        $exists | Should -Be $true
    } 
}

Describe 'Verify RG Bicep' {
    it 'Should deploy a bicep file.' {
        #arrange
        $rgName = "tflintrules"
        $bicepPath = "./main.bicep"
        #act
        $exists = Get-ResourceGroupExists($rgName)

        #assert
        $exists | Should -Be $true
    } 
}