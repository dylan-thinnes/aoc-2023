input =: 1!:1 < 'input'
split =: ([;._2~ LF = ]) input
field =: |: split

square =: '#' = field
round =: 'O' = field

boundaries =: }:"1]: 1 ,"1 square

piles =: boundaries <;.1"1 round
sort_piles_and_rejoin =: [: ;"1 \:~&.>
boulders_per_row =: +/ sort_piles_and_rejoin piles
costs =: +/ boulders_per_row * >: |. i. # boulders_per_row

4 (1!:2)~ LF ,~ ": costs
exit 0
