BeforeAll {
  {{#ResourceTypes}}
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
