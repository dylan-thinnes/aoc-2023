input =: 1!:1 < 'input'
split_on_newline =: <;._2~ LF = ]
split_on_empty =: <@:>;._1~ a: = ]
matrices =: split_on_empty a: , split_on_newline input
rocks =: '#'&=&.> matrices

sum =: [: +/ ,
mirror_lengths =: 0 -.~ [: i: [: <. 2 %~ #
mirror_pair =: {. ,: [: |. [ {. }.
valid_mirror_pair =: 1 = [: sum [: ~:"0/ mirror_pair
valid_mirror_lengths =: # | # + mirror_lengths #~ mirror_lengths valid_mirror_pair"0 _ ]
mirror_score =: [: {. (100 * valid_mirror_lengths) , [: valid_mirror_lengths |:

result =: +/ mirror_score@:>"0 rocks
'' [ 4 (1!:2)~ ": result
