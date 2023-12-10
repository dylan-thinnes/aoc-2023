#!/usr/bin/env jconsole
input =: 1!:1 <'example-input'
divided =: ([;._2~ LF = ]) input
padded =: '.' ,.~ '.' ,. '.' ,~ '.' , divided

''
