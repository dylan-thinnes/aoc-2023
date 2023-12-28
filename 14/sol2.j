NB. Receive input
input =: 1!:1 < 'input'
split =: ([;._2~ LF = ]) input
field =: |: split

NB. Extract unmoving and moving rocks
square =: '#' = field
round =: 'O' = field

NB. Boundaries for boulders rolling n,s,w,e
boundaries_n =: [: }:"1]: 1 ,"1 square +. ]
boundaries_s =: [: }."1]: 1 ,~"1 square +. ]
boundaries_w =: [: }:"1]: 1 ,"1 [: |: square +. ]
boundaries_e =: [: }."1]: 1 ,~"1 [: |: square +. ]

NB. Roll using boundaries
roll_n =: [: ;"1 [: \:~&.> boundaries_n@:[ <;.1"1 ]
roll_s =: [: ;"1 [: /:~&.> boundaries_s@:[ <;.2"1 ]
roll_w =: [: |: [: ;"1 [: \:~&.> boundaries_w@:[ <;.1"1 |:@:]
roll_e =: [: |: [: ;"1 [: /:~&.> boundaries_e@:[ <;.2"1 |:@:]

NB. Cycle by running rolling
cycle =: [ roll_e [ roll_s [ roll_w roll_n

steady_state =: square cycle^:1000 round
cost =: [: +/ [: (* >:@:|.@:i.@:#) +/
cost_history =: |. cost"2 > (square&cycle@:>@:{. ; ])^:1000 < steady_state

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
