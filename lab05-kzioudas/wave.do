onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /top/duv/reset
add wave -noupdate -radix hexadecimal /top/duv/clk
add wave -noupdate -radix hexadecimal /top/duv/stall
add wave -noupdate -radix hexadecimal /top/duv/flush
add wave -noupdate -radix hexadecimal /top/duv/pc
add wave -noupdate -radix hexadecimal /top/duv/npc
add wave -noupdate -divider {ID stage}
add wave -noupdate -radix hexadecimal /top/duv/instruction
#add wave -noupdate -radix hexadecimal -childformat {{{/top/duv/instruction[25]} -radix hexadecimal} {{/top/duv/instruction[24]} -radix hexadecimal} {{/top/duv/instruction[23]} -radix hexadecimal} {{/top/duv/instruction[22]} -radix hexadecimal} {{/top/duv/instruction[21]} -radix hexadecimal}} -subitemconfig {{/top/duv/instruction[25]} {-height 15 -radix hexadecimal} {/top/duv/instruction[24]} {-height 15 -radix hexadecimal} {/top/duv/instruction[23]} {-height 15 -radix hexadecimal} {/top/duv/instruction[22]} {-height 15 -radix hexadecimal} {/top/duv/instruction[21]} {-height 15 -radix hexadecimal}} /top/duv/ra1
#add wave -noupdate -radix hexadecimal -childformat {{{/top/duv/instruction[20]} -radix hexadecimal} {{/top/duv/instruction[19]} -radix hexadecimal} {{/top/duv/instruction[18]} -radix hexadecimal} {{/top/duv/instruction[17]} -radix hexadecimal} {{/top/duv/instruction[16]} -radix hexadecimal}} -subitemconfig {{/top/duv/instruction[20]} {-height 15 -radix hexadecimal} {/top/duv/instruction[19]} {-height 15 -radix hexadecimal} {/top/duv/instruction[18]} {-height 15 -radix hexadecimal} {/top/duv/instruction[17]} {-height 15 -radix hexadecimal} {/top/duv/instruction[16]} {-height 15 -radix hexadecimal}} /top/duv/ra2
add wave -noupdate -radix hexadecimal -label /top/duv/ra1 /top/duv/b2v_pipeline_control/rs
add wave -noupdate -radix hexadecimal -label /top/duv/ra2 /top/duv/b2v_pipeline_control/rt

add wave -noupdate -radix hexadecimal /top/duv/id_rdA
add wave -noupdate -radix hexadecimal /top/duv/id_rdB
add wave -noupdate -radix hexadecimal /top/duv/id_imm
add wave -noupdate -radix hexadecimal -childformat {{{/top/duv/wr[4]} -radix hexadecimal} {{/top/duv/wr[3]} -radix hexadecimal} {{/top/duv/wr[2]} -radix hexadecimal} {{/top/duv/wr[1]} -radix hexadecimal} {{/top/duv/wr[0]} -radix hexadecimal}} -subitemconfig {{/top/duv/wr[4]} {-height 15 -radix hexadecimal} {/top/duv/wr[3]} {-height 15 -radix hexadecimal} {/top/duv/wr[2]} {-height 15 -radix hexadecimal} {/top/duv/wr[1]} {-height 15 -radix hexadecimal} {/top/duv/wr[0]} {-height 15 -radix hexadecimal}} /top/duv/wr
add wave -noupdate /top/duv/regDst
add wave -noupdate /top/duv/id_regWrite
add wave -noupdate -radix hexadecimal /top/duv/pcTarget
add wave -noupdate /top/duv/id_eqFwdA
add wave -noupdate /top/duv/id_eqFwdB
add wave -noupdate -radix hexadecimal /top/duv/eqA
add wave -noupdate -radix hexadecimal /top/duv/eqB
add wave -noupdate /top/duv/brTaken
add wave -noupdate -divider {EX stage}
add wave -noupdate -radix hexadecimal /top/duv/a
add wave -noupdate -radix hexadecimal /top/duv/b
add wave -noupdate -radix hexadecimal /top/duv/ex_forwardA
add wave -noupdate -radix hexadecimal /top/duv/ex_forwardB
add wave -noupdate -radix hexadecimal /top/duv/ex_src2
add wave -noupdate -radix hexadecimal /top/duv/ex_alucont
add wave -noupdate -radix hexadecimal /top/duv/ex_aluOut
add wave -noupdate /top/duv/ex_regWrite
add wave -noupdate -radix hexadecimal /top/duv/ex_rd
add wave -noupdate -divider {MEM stage}
add wave -noupdate -radix hexadecimal /top/duv/mem_src2
add wave -noupdate -radix hexadecimal /top/duv/mem_aluOut
add wave -noupdate -radix hexadecimal /top/duv/mem_memWrite
add wave -noupdate -radix hexadecimal /top/duv/mem_mo
add wave -noupdate -divider {WB stage}
add wave -noupdate -radix hexadecimal /top/duv/wb_memToReg
add wave -noupdate -radix hexadecimal /top/duv/wb_writeData
add wave -noupdate -radix hexadecimal /top/duv/wb_rd
add wave -noupdate -radix hexadecimal /top/duv/wb_regWrite
add wave -noupdate -divider Other
add wave -noupdate /top/cycle_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10747 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 325
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {9153 ps} {12649 ps}
