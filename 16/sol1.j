input =: 1!:1 < 'input'
input =: ([;._2~ LF = ]) input

cleared =: 0 $~ $ input

ud_mirrors =: '|' = input
lr_mirrors =: '-' = input
blanks =: '.' = input
fs_mirrors =: '/' = input
bs_mirrors =: '\' = input

repeat =: [ , [ , [ ,: [

NB. Beam RLDU
beams =: 0 = i. 4 , $ input

move_rays =: (0 _1 , 0 1 , _1 0 ,: 1 0) |.!.0"1 2 ]
sim_blanks =: [: move_rays blanks *"2 ]
sim_lr_to_ud =: [: move_rays 0 0 1 1 *"0 2 ud_mirrors *"2 [: +./ 0 1 { ]
sim_ud_to_lr =: [: move_rays 1 1 0 0 *"0 2 lr_mirrors *"2 [: +./ 2 3 { ]
sim_ud_to_ud =: [: move_rays 0 0 1 1 *"0 2 ud_mirrors *"2 ]
sim_lr_to_lr =: [: move_rays 1 1 0 0 *"0 2 lr_mirrors *"2 ]
sim_fs =: [: move_rays 3 2 1 0 { fs_mirrors *"2 ]
sim_bs =: [: move_rays 2 3 0 1 { bs_mirrors *"2 ]

sim =: [ +. sim_blanks +. sim_lr_to_ud +. sim_ud_to_lr +. sim_ud_to_ud +. sim_lr_to_lr +. sim_fs +. sim_bs
sim_until_done =: sim^:_
answer =: +/ +/ +./ sim_until_done beams
