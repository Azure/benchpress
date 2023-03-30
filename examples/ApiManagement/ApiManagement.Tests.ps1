BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:apiServiceName = 'servicetest'
  $Script:apiName = 'apitest'
  $Script:location = 'westus3'
}

Describe 'Verify API Management Service' {
  BeforeAll {
    $Script:noApiServiceName = 'noservice'
  }

  It 'Should contain an API Management Service with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "ApiManagement"
      ResourceGroupName = $rgName
      ResourceName = $apiServiceName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }
  It "Should contain an API Management Service named $apiServiceName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "ApiManagement"
      ResourceGroupName = $rgName
      ResourceName = $apiServiceName
      PropertyKey = 'Name'
      PropertyValue = $apiServiceName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain an API Management Service with the given name' {
    #act
    $result = Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an API Management Service with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name = $noApiServiceName
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPApiManagement @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an API Management Service named $apiServiceName" {
    #act
    $result = Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain an API Management Service named $apiServiceName in $location" {
    #act
    $result = Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be an API Management Service in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management API' {
  BeforeAll {
    $Script:noApiName = 'noapi'
  }

  It 'Should contain an API Management API with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "ApiManagementApi"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $apiName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an API Management API named $apiName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "ApiManagementApi"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $apiName
      PropertyKey = 'Name'
      PropertyValue = $apiName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain an API Management API with the given name' {
    #act
    $result = Confirm-AzBPApiManagementApi -ResourceGroupName $rgName -ServiceName $apiServiceName -Name $apiName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an API Management API with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name = $noApiName
      ServiceName = $apiServiceName
      ErrorAction = "SilentlyContinue"
    }
    $result = Confirm-AzBPApiManagementApi @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an API Management API named $apiName" {
    #act
    $result = Confirm-AzBPApiManagementApi -ResourceGroupName $rgName -ServiceName $apiServiceName -Name $apiName

    #assert
    $result | Should -BeDeployed
  }

  It "Should be an API Management API in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPApiManagementApi -ResourceGroupName $rgName -ServiceName $apiServiceName -Name $apiName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Diagnostic' {
  BeforeAll {
    $Script:diagnosticName = 'diagtest'
    $Script:noDiagnosticName = 'nodiag'
  }

  It 'Should contain an API Management Diagnostic with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "ApiManagementDiagnostic"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $diagnosticName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an API Management Diagnostic named $diagnosticName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "ApiManagementDiagnostic"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $diagnosticName
      PropertyKey = 'DiagnosticId'
      PropertyValue = $diagnosticName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain an API Management Diagnostic with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $diagnosticName
    }

    #act
    $result = Confirm-AzBPApiManagementDiagnostic @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an API Management Diagnostic with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $noDiagnosticName
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPApiManagementDiagnostic @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an API Management Diagnostic named $diagnosticName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $diagnosticName
    }

    #act
    $result = Confirm-AzBPApiManagementDiagnostic @params

    #assert
    $result | Should -BeDeployed
  }

  It "Should be an API Management Diagnostic in a resource group named $rgName" {
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $diagnosticName
    }

    #act
    $result = Confirm-AzBPApiManagementDiagnostic @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Logger' {
  BeforeAll {
    $Script:loggerName = 'loggertest'
    $Script:noLoggerName = 'nologger'
  }

  It 'Should contain an API Management Logger with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "ApiManagementLogger"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $loggerName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an API Management Logger named $loggerName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "ApiManagementLogger"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $loggerName
      PropertyKey = 'LoggerId'
      PropertyValue = $loggerName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain an API Management Logger with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $loggerName
    }

    #act
    $result = Confirm-AzBPApiManagementLogger @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an API Management Logger with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $noLoggerName
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPApiManagementLogger @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an API Management Logger named $loggerName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $loggerName
    }

    #act
    $result = Confirm-AzBPApiManagementLogger @params

    #assert
    $result | Should -BeDeployed
  }

  It "Should be an API Management Logger in a resource group named $rgName" {
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      Name = $loggerName
    }

    #act
    $result = Confirm-AzBPApiManagementLogger @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Policy' {
  BeforeAll {
    $Script:noApiId = 'nopolicy'
  }

  It "Should contain an API Management Policy for the API ID $apiName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType = "ApiManagementPolicy"
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ResourceName = $apiName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an API Management Policy for the API ID $apiName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ApiId = $apiName
    }

    #act
    $result = Confirm-AzBPApiManagementPolicy @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should not contain an API Management Policy for the API ID $apiName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ApiId = $noApiId
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPApiManagementPolicy @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an API Management Policy for the API ID $apiName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName = $apiServiceName
      ApiId = $apiName
    }

    #act
    $result = Confirm-AzBPApiManagementPolicy @params

    #assert
    $result | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
