#!/usr/bin/env jconsole
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input
padded =: '.' ,.~ '.' ,. '.' ,~ '.' , divided

down_alone =: 'S|F7' e.~ padded
up_alone =: 'S|LJ' e.~ padded
left_alone =: 'S-7J' e.~ padded
right_alone =: 'S-FL' e.~ padded

down =: down_alone *. 1 0 |. up_alone
up =: up_alone *. _1 0 |. down_alone
left =: left_alone *. 0 _1 |. right_alone
right =: right_alone *. 0 1 |. left_alone

s =: padded = 'S'
glob_adjacent_pipes =: ] +. (left *. 0 _1 |. ]) +. (right *. 0 1 |. ]) +. (up *. _1 0 |. ]) +. (down *. 1 0 |. ])
globbed_pipes =: glob_adjacent_pipes^:_ s
result =: globbed_pipes {"0 1 '.' ,"0 padded

lines_above =: +/\ globbed_pipes * right
tiles_with_even_lines =: 2 | lines_above * -. globbed_pipes
total =: +/ +/ tiles_with_even_lines
4 (1!:2)~ ": total
exit 0
