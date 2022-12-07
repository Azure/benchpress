BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/ContainerRegistry.psm1"
  Import-Module "../BenchPress/Helpers/Azure/Bicep.psm1"
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg_benchpress_test_1"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-ContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg_benchpress_test_1"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-ContainerRegistryExists -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Be $true
  }
}
