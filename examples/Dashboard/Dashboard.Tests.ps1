BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName   = 'rg-test'
  $Script:location = 'westus3'
  $Script:dashboardName = 'sampleDashboard'
}

Describe 'Verify Dashboard' {
  It "Should contain a Dashboard named $dashboardName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "PortalDashboard"
      ResourceName      = $dashboardName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Dashboard named $dashboardName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "PortalDashboard"
      ResourceName      = $dashboardName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $dashboardName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Dashboard named $dashboardName" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeSuccessful
  }

  It "Should contain a Dashboard named $dashboardName in $location" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeInLocation $location
  }

  It "Should contain a Dashboard named $dashboardName in $rgName" {
    Confirm-AzBPPortalDashboard -ResourceGroupName $rgName -Name $dashboardName | Should -BeInResourceGroup $rgName
  }
}
