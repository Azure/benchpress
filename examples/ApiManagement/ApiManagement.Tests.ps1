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

  It 'Should contain an API Management Service named $apiServiceName - Confirm-AzBPResource' {
    # arrange
    $params = @{
      ResourceType      = "ApiManagement"
      ResourceGroupName = $rgName
      ResourceName      = $apiServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
  It "Should contain an API Management Service named $apiServiceName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagement"
      ResourceGroupName = $rgName
      ResourceName      = $apiServiceName
      PropertyKey       = 'Name'
      PropertyValue     = $apiServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Service named $apiServiceName" {
    Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName | Should -BeSuccessful
  }

  It "Should not contain an API Management Service named $noApiServiceName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noApiServiceName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPApiManagement @params | Should -Not -BeSuccessful
  }

  It "Should contain an API Management Service named $apiServiceName in $location" {
    Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName | Should -BeInLocation $location
  }

  It "Should contain an API Management Service named $apiServiceName in $rgName" {
    Confirm-AzBPApiManagement -ResourceGroupName $rgName -Name $apiServiceName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management API' {
  BeforeAll {
    $Script:noApiName = 'noapi'
  }

  It "Should contain an API Management API named $apiName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementApi"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $apiName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management API named $apiName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementApi"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $apiName
      PropertyKey       = 'Name'
      PropertyValue     = $apiName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management API named $apiName" {
    Confirm-AzBPApiManagementApi -ResourceGroupName $rgName -ServiceName $apiServiceName -Name $apiName
    | Should -BeSuccessful
  }

  It "Should not contain an API Management API named $noApiName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noApiName
      ServiceName       = $apiServiceName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPApiManagementApi @params | Should -Not -BeSuccessful
  }

  It "Should contain an API Management API named $apiName in $rgName" {
    Confirm-AzBPApiManagementApi -ResourceGroupName $rgName -ServiceName $apiServiceName -Name $apiName
    | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Diagnostic' {
  BeforeAll {
    $Script:diagnosticName = 'diagtest'
    $Script:noDiagnosticName = 'nodiag'
  }

  It "Should contain an API Management Diagnostic named $diagnosticName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementDiagnostic"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $diagnosticName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Diagnostic named $diagnosticName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementDiagnostic"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $diagnosticName
      PropertyKey       = 'DiagnosticId'
      PropertyValue     = $diagnosticName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Diagnostic named $diagnosticName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $diagnosticName
    }

    # act and assert
    Confirm-AzBPApiManagementDiagnostic @params | Should -BeSuccessful
  }

  It "Should not contain an API Management Diagnostic named $noDiagnosticName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $noDiagnosticName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPApiManagementDiagnostic @params | Should -Not -BeSuccessful
  }

  It "Should contain an API Management Diagnostic named $diagnosticName in $rgName" {
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $diagnosticName
    }

    # act and assert
    Confirm-AzBPApiManagementDiagnostic @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Logger' {
  BeforeAll {
    $Script:loggerName = 'loggertest'
    $Script:noLoggerName = 'nologger'
  }

  It "Should contain an API Management Logger named $loggerName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementLogger"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $loggerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Logger named $loggerName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementLogger"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $loggerName
      PropertyKey       = 'LoggerId'
      PropertyValue     = $loggerName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Logger named $loggerName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $loggerName
    }

    # act and assert
    Confirm-AzBPApiManagementLogger @params | Should -BeSuccessful
  }

  It "Should not contain an API Management Logger named $noLoggerName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $noLoggerName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPApiManagementLogger @params | Should -Not -BeSuccessful
  }

  It "Should contain an API Management Logger named $loggerName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      Name              = $loggerName
    }

    # act and assert
    Confirm-AzBPApiManagementLogger @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify API Management Policy' {
  BeforeAll {
    $Script:noApiId = 'nopolicy'
  }

  It "Should contain an API Management Policy for the API ID $apiName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ApiManagementPolicy"
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ResourceName      = $apiName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an API Management Policy for the API ID $apiName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ApiId             = $apiName
    }

    # act and assert
    Confirm-AzBPApiManagementPolicy @params | Should -BeSuccessful
  }

  It "Should not contain an API Management Policy for the API ID $apiName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ServiceName       = $apiServiceName
      ApiId             = $noApiId
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPApiManagementPolicy @params | Should -Not -BeSuccessful
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
