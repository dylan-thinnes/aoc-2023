#!/usr/bin/env jconsole
NB. Parse input into a padded array of characters
input =: 1!:1 <'example-input-2'
divided =: ([;._2~ LF = ]) input

stars =: divided = '#'
shape =: $ stars
star_indices =: stars #&:, i. shape

distance_between =: [: +/ [: (* *) -&:(shape #: ])

all_distances =: distance_between"0/~ star_indices
interesting_distances =: (<: <: # star_indices) >: +/"1]: (2 # # star_indices) #: i. (2 # # star_indices)
total =: +/ +/ interesting_distances * |."1 all_distances
