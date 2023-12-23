+ # Create initial array bound marker
[
  > >>>>[-]+<<<< # Initialize next array bound marker
  > # Allocate sigil of 0
  ,+ # Set input value, increment to prevent infinite loop

  -[
    -[
      -[[-] # Clear input value
        # IGNORE SIGIL <-> # Decrement sigil to -1
        # CASE 3
        >>>[<<<<<] # Clear array bound markers
        >>>>> # Initialize new array bound marker
        <<< # Account for navigation
        <-> # Decrement new sigil to -1
      ]
      [>]< # Dead reckoning onto sigil
      + # Increment sigil by 1, becoming 0 if the previous branch was taken, and 1 otherwise
      [-> # Clear sigil
        # CASE 2
        >+<
      <]
      -> # Decrement sigil to -1, move back to empty test value
    ]
    [>]< # Dead reckoning onto sigil
    + # Increment sigil by 1, becoming 0 if the previous branch was taken, and 1 otherwise
    [-> # Clear sigil
      # CASE 1
      ><
    <]
    -> # Decrement sigil to -1, move back to empty test value
  ]
  [>]< # Dead reckoning onto sigil
  + # Increment sigil by 1, becoming 0 if the previous branch was taken, and 1 otherwise
  [-> # Clear sigil
    # CASE 0 (end of file)
    >>>[-]<<<
  <]
  >>>> # Navigate to next array bound marker
]
+<<<<<
[>>>.>>]
