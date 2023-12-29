NB. Receive input, pad with walls
input =: 1!:1 < 'input'
split =: ([;._2~ LF = ]) input
field =: '#' ,~"1]: '#' ,"1]: '#' ,~ '#' , split

NB. Extract unmoving and moving rocks
square =: '#' = field
round =: 'O' = field
render =: '.#OX' {~ square + 2 * ]

NB. Roll west along one dimension
roll =: [: ; [: \:~&.> <;.2

NB. Roll w,e,n,s on 2D
roll_w =: roll"1
roll_e =: roll&.|."1
roll_n =: roll"1&.|:
roll_s =: roll&.|."1&.|:

NB. Cycle by running all four rolls
cycle =: square roll_e square roll_s square roll_w square roll_n ]

NB. Calculate cost by multiplying by column vector of descending indices
NB. e.g. (n, n-1, ..., 1)
cost =: [: +/ [: (* |.@:i.@:#) +/"1

NB. Utils to iterate until a previous state is seen
list_head_isnt_duplicate =: [: -. {. e. }.
attach_new_cycle =: cycle@:>@:{. ; ]
until_cycle_loops =: attach_new_cycle^:list_head_isnt_duplicate^:_

NB. Enumerate all states until a previous state is seen
loop =: until_cycle_loops < round

NB. Figure out where loop starts
loop_start_index =: >: (}. i. {.) loop

NB. Using loop start index, figure out the billionth_state if this loop ran
NB. on forever
billionth_loop_index =: loop_start_index | <: - 1000000000 + loop_start_index - # loop
billionth_state =: billionth_loop_index { loop

NB. Print cost of billionth_state
4 (1!:2)~ LF ,~ ": cost > billionth_state
exit 0
