BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:resourceName = 'testvm'
}

Describe 'Verify Resource Exists' {
  It "Should contain a Resource Group named $rgName" {
    #act
    $result = Get-AzBPResourceByType -ResourceType "ResourceGroup" -ResourceName $rgName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Virtual Machine named $resourceName" {
    #act
    $result = Get-AzBPResourceByType -ResourceType "VirtualMachine" -ResourceName $resourceName -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a resource named $resourceName" {
    #act
    $exists = Get-AzBPResource -ResourceName $resourceName

    #assert
    $exists | Should -Not -Be $null
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}

