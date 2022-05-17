BeforeAll{
    {{#ResourceTypes}}
    . {{ Library }}
    {{/ResourceTypes}}
}

{{#TestCases}}
Describe '{{ Name }}' {
    it '{{ Description }}' {
        #arrange
        {{ ValueToCheckVariable }} = {{{ ValueToCheck }}}

        #act
        {{ ActualValueVariable }} = {{GetValueFunctionName}} {{{GetValueFunctionParameterList}}}

        #assert
        {{ ActualValueVariable }} | Should -Be {{{ ExpectedValue }}}
    } 
}
{{/TestCases}}
