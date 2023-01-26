[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '',
                                                          Justification='This is an auto generated file by the
                                                          Generator and should be ignored for now as the Generator
                                                          is still under development.')]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UnexpectedToken', '')]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('MissingEndCurlyBrace', '')]
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('InvalidLeftHandSide', '')]
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
