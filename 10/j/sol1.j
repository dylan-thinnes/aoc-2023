#!/usr/bin/env jconsole
NB. Parse input into a padded array of characters
input =: 1!:1 <'example-input-3'
divided =: ([;._2~ LF = ]) input
padded =: '.' ,.~ '.' ,. '.' ,~ '.' , divided

NB. Find all pips pointing in a direction
down_alone =: 'S|F7' e.~ padded
up_alone =: 'S|LJ' e.~ padded
left_alone =: 'S-7J' e.~ padded
right_alone =: 'S-FL' e.~ padded

NB. Find all pipes that link with a pipe on the other end
down =: down_alone *. 1 0 |. up_alone
up =: up_alone *. _1 0 |. down_alone
left =: left_alone *. 0 _1 |. right_alone
right =: right_alone *. 0 1 |. left_alone

NB. Find location of S
s =: padded = 'S'

NB. Given a matrix of pipes that are attached to S, find all pipes adjacent to
NB. those pipes that also point into them
glob_adjacent_pipes =: ] +. (left *. 0 _1 |. ]) +. (right *. 0 1 |. ]) +. (up *. _1 0 |. ]) +. (down *. 1 0 |. ])

NB. Run adjacency an infinite number of times (stops on fixpoint)
globbed_pipes =: glob_adjacent_pipes^:_ s
result =: globbed_pipes {"0 1 '.' ,"0 padded

NB. Calculate total number of globbed_pipes by summing the matrix
total =: +/ +/ globbed_pipes

NB. Print total
4 (1!:2)~ ": total % 2
exit 0
