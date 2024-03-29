[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
param()

BeforeAll {
  {{#ResourceTypes}}
  $generated = (Get-Content -Path "./generated.parameters.json" | ConvertFrom-Json)
  $parameters = $generated.parameters
  $variables = $generated.variables
  . {{ Library }}
  {{/ResourceTypes}}
}

{{#TestCases}}
Describe '{{ Name }}' {
  it '{{ Description }}' {
    # arrange
    $params = @{
      {{ #Parameters }}
      {{ Key }} = {{{ Value }}}
      {{ /Parameters}}
    }

    # act and assert
    {{ FunctionName }} @params | Should {{{ AssertionDetails }}}
  }
}

{{/TestCases}}
