input =: 1!:1 < 'input'
split =: (<;._2~ ',' e.~ ]) ',' ,~ (#~ LF ~: ]) input

step =: 256 | 17 * +
hash =: [: step/ [: |. 0 , 3 u: ]
parse =: (<;._2~ '=- ' e.~ ]) ' ' ,~ ]
answer =: +/ hash@:>"0 split
