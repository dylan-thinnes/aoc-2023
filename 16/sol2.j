NB. Parse input
input =: 1!:1 < 'input'
input =: ([;._2~ LF = ]) input

NB. Extract mirrors
ud_mirrors =: '|' = input
lr_mirrors =: '-' = input
blanks =: '.' = input
fs_mirrors =: '/' = input
bs_mirrors =: '\' = input

NB. Simulate beams of light reflecting off different kinds of mirrors
sim_blanks =: (blanks +."2 (lr_mirrors , lr_mirrors , ud_mirrors ,: ud_mirrors)) *. ]
sim_lr_to_ud =: 0 0 1 1 *."0 2 ud_mirrors *."2 [: +./ 0 1 { ]
sim_ud_to_lr =: 1 1 0 0 *."0 2 lr_mirrors *."2 [: +./ 2 3 { ]
sim_fs =: 3 2 1 0 { fs_mirrors *."2 ]
sim_bs =: 2 3 0 1 { bs_mirrors *."2 ]

NB. Simulate beams of light moving futher after reflection
move_rays =: (0 _1 , 0 1 , _1 0 ,: 1 0) |.!.0"1 2 ]
sim =: [ +. [: move_rays sim_blanks +. sim_lr_to_ud +. sim_ud_to_lr +. sim_fs +. sim_bs
sim_until_done =: sim^:_

NB. Run a whole simulation, and calculate score
score =: [: +/ [: +/ [: +./ sim_until_done

NB. Generate all possible starting beam configurations
height =: 0 { $ input
width =: 1 { $ input
possible_beam_idxs =: i. 4 , height , width

r_beams =: width * i. height
l_beams =: r_beams + <: width + width * height
d_beams =: (width * height * 2) + i. width
u_beams =: width -~ (width * height * 2) + d_beams

all_possible_beams =: (r_beams , l_beams , d_beams , u_beams) ="0 3 possible_beam_idxs

NB. Score every possible beam config, take the maximum
answer =: >./ score"3 all_possible_beams
'' [ 4 (1!:2)~ ": answer
exit 0
