#!/usr/bin/env jconsole
NB. Parse input into a padded array of characters
input =: 1!:1 <'input'
divided =: ([;._2~ LF = ]) input

NB. Turn the input into a logical matrix of stars
stars =: divided = '#'

NB. Calculate how many stars are in each column/row
col_stars =: +/ stars
row_stars =: +/"1 stars

NB. Calculate what the distances are for each column/row
col_distances =: 1000000 1 {~ +./ stars
row_distances =: 1000000 1 {~ +./"1 stars

NB. For a 1D array of stars, calculate how many times each location between the
NB. stars is visited by a journey
NB. We do this by multiplying a cumulative sum of the array by a reverse
NB. cumulative sum
journeys =: +/\. * [: }: 0 , +/\

NB. Multiply the journeys taken in each col/row by the cost of that col/row
horizontal =: +/ col_distances * journeys col_stars
vertical =: +/ row_distances * journeys row_stars
total =: horizontal + vertical
4 (1!:2)~ LF ,~ ": total
exit 0
