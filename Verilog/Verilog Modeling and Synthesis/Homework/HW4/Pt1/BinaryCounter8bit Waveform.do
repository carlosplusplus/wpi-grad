onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /BinaryCounter8bitTester/clk
add wave -noupdate -format Logic /BinaryCounter8bitTester/rst
add wave -noupdate -format Logic /BinaryCounter8bitTester/init
add wave -noupdate -format Logic /BinaryCounter8bitTester/cin
add wave -noupdate -format Logic /BinaryCounter8bitTester/cout
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[7]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[6]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[5]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[4]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[3]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[2]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[1]/genblk1/cc/Q}
add wave -noupdate -format Logic {/BinaryCounter8bitTester/UUT/counter_cells[0]/genblk1/cc/Q}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2992900 ps} 0}
configure wave -namecolwidth 339
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
WaveRestoreZoom {0 ps} {3150 ns}
