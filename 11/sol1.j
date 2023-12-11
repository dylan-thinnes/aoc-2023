#!/usr/bin/env jconsole
NB. Parse input into a padded array of characters
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input

stars =: divided = '#'
shape =: $ stars
star_indices =: stars #&:, i. shape

x_gaps =: >: -. +./ stars
x_range =: ((i. 1 { shape) >: <.) *. ((i. 1 { shape) <: >.)
x_from_index =: 1 { shape #: ]
x_distance =: [: <: [: +/ x_gaps * x_range&:x_from_index

y_gaps =: >: -. +./"1 stars
y_range =: ((i. 0 { shape) >: <.) *. ((i. 0 { shape) <: >.)
y_from_index =: 0 { shape #: ]
y_distance =: [: <: [: +/ y_gaps * y_range&:y_from_index

distance_between =: x_distance + y_distance

all_distances =: distance_between"0/~ star_indices
interesting_distances =: (<: <: # star_indices) >: +/"1]: (2 # # star_indices) #: i. (2 # # star_indices)
total =: +/ +/ interesting_distances * |."1 all_distances
