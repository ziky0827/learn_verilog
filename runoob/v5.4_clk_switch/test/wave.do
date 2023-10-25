onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Coral /test/clk_100mhz
add wave -noupdate -color {Orange Red} /test/clk_200mhz
add wave -noupdate -color Yellow /test/rstn
add wave -noupdate -color Gold /test/u_clk_switch/sel_clk1
add wave -noupdate -color Magenta /test/u_clk_switch/clk_out
add wave -noupdate -expand -subitemconfig {{/test/u_clk_switch/sel_clk1_r[2]} {-height 20} {/test/u_clk_switch/sel_clk1_r[1]} {-height 20} {/test/u_clk_switch/sel_clk1_r[0]} {-height 20}} /test/u_clk_switch/sel_clk1_r
add wave -noupdate -expand -subitemconfig {{/test/u_clk_switch/sel_clk1_neg_r[1]} {-height 20} {/test/u_clk_switch/sel_clk1_neg_r[0]} {-height 20}} /test/u_clk_switch/sel_clk1_neg_r
add wave -noupdate -expand -subitemconfig {{/test/u_clk_switch/sel_clk2_r[2]} {-height 20} {/test/u_clk_switch/sel_clk2_r[1]} {-height 20} {/test/u_clk_switch/sel_clk2_r[0]} {-height 20}} /test/u_clk_switch/sel_clk2_r
add wave -noupdate -expand -subitemconfig {{/test/u_clk_switch/sel_clk2_neg_r[1]} {-height 20} {/test/u_clk_switch/sel_clk2_neg_r[0]} {-height 20}} /test/u_clk_switch/sel_clk2_neg_r
add wave -noupdate /test/u_clk_switch/clk1_gate
add wave -noupdate /test/u_clk_switch/clk2_gate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {872990 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {11569 ps} {117244 ps}
