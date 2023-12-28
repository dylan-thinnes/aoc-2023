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

NB. Calculate cost by multiplying by column vector of descending indices (n, n-1, ..., 1)
cost =: [: +/ [: (* |.@:i.@:#) +/"1

NB. Iterate until a previous state is seen
steady_state =: cycle^:1000 round

NB. Calculate cost of positions
cost_history =: |. cost"2 > (cycle@:>@:{. ; ])^:1000 < steady_state

periodic_mask_n =: 0 = (| [: i. #)
periodic_xs =: ] #~ periodic_mask_n
is_monotonic =: 1 = [: # [: ~. }. - }:
find_period_size =: 3 : 0
for_i. >: i. # y do.
  result =: i
  if. is_monotonic i periodic_xs y do.
    break.
  end.
end.
result
)

extrapolate_history_to_billion =: {~ (1000000000 - 1000) | find_period_size
4 (1!:2)~ LF ,~ ": extrapolate_history_to_billion cost_history
exit 0
