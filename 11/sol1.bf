+ # Create initial array bound marker
[
  > >>>>[-]+<<<< # Initialize next array bound marker
  > # Allocate sigil of 0
  ,+ # Set input value increment to prevent infinite loop

  -[
    -[
      -[[-] # Clear input value
        # IGNORE SIGIL <-> # Decrement sigil to _1
        # CASE 3
        >>>-<<<<< # Clear extra bound marker
        [<<<<<] # Move to front
        >> # Account for navigation
        <-> # Decrement new sigil to _1
      ]
      [>]< # Dead reckoning onto sigil
      + # Increment sigil by 1 becoming 0 if the previous branch was taken and 1 otherwise
      [-> # Clear sigil
        # CASE 2
        >+<
      <]
      -> # Decrement sigil to _1 move back to empty test value
    ]
    [>]< # Dead reckoning onto sigil
    + # Increment sigil by 1 becoming 0 if the previous branch was taken and 1 otherwise
    [-> # Clear sigil
      # CASE 1
      ><
    <]
    -> # Decrement sigil to _1 move back to empty test value
  ]
  [>]< # Dead reckoning onto sigil
  + # Increment sigil by 1 becoming 0 if the previous branch was taken and 1 otherwise
  [-> # Clear sigil
    # CASE 0 (end of file)
    >>>[-]<<<
  <]
  >>>> # Navigate to next array bound marker
]
+ # Reinitialize second marker
<<<<< # Move to initial marker
>>>>>[<<.>>>>>>>] # Starting from second marker, print each preceding element
