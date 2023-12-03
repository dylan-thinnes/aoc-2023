#!/usr/bin/env jconsole
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input
padded =: '.' ,.~ '.' ,. '.' ,~ '.' , divided

is_number =: '0123456789' e.~ ]
number_chars =: is_number padded

get_transition_boundaries =: 1 , }.~:}:
number_region_boundaries =: get_transition_boundaries"1 number_chars
all_regions =: number_region_boundaries <;.1"1 padded

under_right_argument =: ]:&.>@:]
ignore_characters =: 1:"0 under_right_argument
parse_n_copies =: (# # ".) under_right_argument
every_other =: 2 | [: i. #

ignore_then_parse =: every_other ignore_characters`parse_n_copies@.["0 ]
parse_all_numbers =: ([: ; ignore_then_parse)"1 all_regions

left_outer_border =: 2b0100 b. 1 |."1 ]
right_outer_border =: 2b0100 b. _1 |."1 ]
convolve_y_additive =: [: +/ _1 0 1 |."0 2 ]

adjacent_to_numbers =: convolve_y_additive (left_outer_border + right_outer_border + ]) number_chars
gears_adjacent_to_two_numbers =: (2 = adjacent_to_numbers) *. '*' = padded

value_or_one =: [ { 1 , ]
left_border =: 2b0010 b. _1 |."1 ]
right_border =: 2b0010 b. 1 |."1 ]
left_multive_border =: 1 |."1 (left_border number_chars) value_or_one"0 parse_all_numbers
right_multive_border =: _1 |."1 (right_border number_chars) value_or_one"0 parse_all_numbers
convolve_y_mult =: [: */ _1 0 1 |."0 2 ]
multiplied_adjacent_numbers =: convolve_y_mult left_multive_border * right_multive_border * parse_all_numbers

gear_values =: gears_adjacent_to_two_numbers * multiplied_adjacent_numbers

total =: +/ , gear_values
4 (1!:2)~ ": total
exit 0
