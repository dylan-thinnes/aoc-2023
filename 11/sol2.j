#!/usr/bin/env jconsole
NB. Parse input into a padded array of characters
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input

stars =: divided = '#'
col_stars =: +/ stars
row_stars =: +/"1 stars
col_distances =: 1000000 1 {~ +./ stars
row_distances =: 1000000 1 {~ +./"1 stars

NB. From an index <n> in an array of stars, calculate the steps to reach all
NB. other stars to the right
rightwards_journeys =: (0 #~ [) , 0 , [: }. { * [: +/\. }.

NB. Run rightwards_journeys for all indices
all_journeys =: [: +/ ([: i. #) rightwards_journeys"0 1 ]

horizontal =: +/ col_distances * all_journeys col_stars
vertical =: +/ row_distances * all_journeys row_stars
total =: horizontal + vertical
4 (1!:2)~ ": total
exit 0
