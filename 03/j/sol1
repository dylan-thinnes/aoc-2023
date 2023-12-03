#!/usr/bin/env jconsole
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input
padded =: '.' ,.~ '.' ,. '.' ,~ '.' , divided

convolve_xy =: [: +./ (<: 3 3 #: i. 9) |. ]
convolve_x =: [: |: [: +./ _1 0 1 |."0 2 |:

is_number =: '0123456789' e.~ ]
is_symbol =: [: -. '0123456789.' e.~ ]

numbers =: is_number padded

initial_globbed_numbers =: numbers *. convolve_xy is_symbol padded
glob_adjacent =: numbers *. convolve_x
all_globbed_numbers =: glob_adjacent^:_ initial_globbed_numbers

change_adjacent =: ~: _1 |."1 ]
all_globbed_number_boundaries =: change_adjacent all_globbed_numbers
all_regions =: (, padded) <;.1~ , all_globbed_number_boundaries

every_other =: #~ 2 | 1 + [: i. #
number_regions =: every_other all_regions

parse_every =: ".@:>"0
numbers =: parse_every number_regions

total =: +/ numbers
4 (1!:2)~ ": total
exit 0
