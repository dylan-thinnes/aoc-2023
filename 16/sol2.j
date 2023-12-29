input =: 1!:1 < 'input'
input =: ([;._2~ LF = ]) input

cleared =: 0 $~ $ input

ud_mirrors =: '|' = input
lr_mirrors =: '-' = input
blanks =: '.' = input
fs_mirrors =: '/' = input
bs_mirrors =: '\' = input

repeat =: [ , [ , [ ,: [

height =: 0 { $ input
width =: 1 { $ input
beam_idxs =: i. 4 , height , width

right_beams =: width * i. height
left_beams =: right_beams + <: width + width * height
down_beams =: (width * height * 2) + i. width
up_beams =: width -~ (width * height * 4) + i. width

all_possible_beams =: (right_beams , left_beams , down_beams , up_beams) ="0 3 beam_idxs

sim_blanks =: blanks *"2 ]
sim_lr_to_ud =: 0 0 1 1 *."0 2 ud_mirrors *."2 [: +./ 0 1 { ]
sim_ud_to_lr =: 1 1 0 0 *."0 2 lr_mirrors *."2 [: +./ 2 3 { ]
sim_ud_to_ud =: 0 0 1 1 *."0 2 ud_mirrors *."2 ]
sim_lr_to_lr =: 1 1 0 0 *."0 2 lr_mirrors *."2 ]
sim_fs =: 3 2 1 0 { fs_mirrors *."2 ]
sim_bs =: 2 3 0 1 { bs_mirrors *."2 ]

move_rays =: (0 _1 , 0 1 , _1 0 ,: 1 0) |.!.0"1 2 ]
sim =: [ +. [: move_rays sim_blanks +. sim_lr_to_ud +. sim_ud_to_lr +. sim_ud_to_ud +. sim_lr_to_lr +. sim_fs +. sim_bs
sim_until_done =: sim^:_
score =: [: +/ [: +/ [: +./ sim_until_done

answer =: >./ score"3 all_possible_beams
'' [ 4 (1!:2)~ ": answer
exit 0
