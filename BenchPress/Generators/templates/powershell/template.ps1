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
    #arrange
    {{ #Parameters }}
    {{ Key }} = {{{ Value }}}
    {{ /Parameters}}

    #act
    {{ ActualValueVariable }} = {{GetValueFunctionName}} {{{GetValueFunctionParameterList}}}

    #assert
    {{ ActualValueVariable }} | Should -Be {{{ ExpectedValue }}}
  }
}

{{/TestCases}}



