BeforeAll {
  Import-Module BenchPress.Azure

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:name = 'samplesearchservice'
}

Describe 'Verify Search Service' {
  BeforeAll {
  }

  It "Should contain a Search Service named $name - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SearchService"
      ResourceName      = $name
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain a Search Service named $name - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SearchService"
      ResourceName      = $name
      ResourceGroupName = $rgName
      PropertyKey       = 'Name'
      PropertyValue     = $name
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Search Service named $name" {
    Confirm-AzBPSearchService -ResourceGroupName $rgName -Name $name | Should -BeSuccessful
  }

  It "Should contain a Search Service named $name in $location" {
    Confirm-AzBPSearchService -ResourceGroupName $rgName -Name $name | Should -BeInLocation $location
  }

  It "Should contain a Search Service named $name in $rgName" {
    Confirm-AzBPSearchService -ResourceGroupName $rgName -Name $name | Should -BeInResourceGroup $rgName
  }
}


AfterAll {
  Get-Module BenchPress.Azure | Remove-Module
}
