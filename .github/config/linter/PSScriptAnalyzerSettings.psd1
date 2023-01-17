@{
  Severity            = @('Error', 'Warning')
  IncludeDefaultRules = $true
  ExcludeRules        = @('PSProvideCommentHelp',
                          'PSUseShouldProcessForStateChangingFunctions',
                          'PSAvoidUsingInvokeExpression')
}
