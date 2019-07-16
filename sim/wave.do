onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/clk
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/reset
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/read
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/write
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/address
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/data_in
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/read_valid
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/data_out
add wave -noupdate -expand -group peripheral_top /peripheral_tb/dut/irq
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/clk
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/reset
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/read
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/write
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/address
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/data_in
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/read_valid
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/data_out
add wave -noupdate -expand -group avalon_register_adapter /peripheral_tb/dut/avalon_register_adapter/reg_address
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/irq_out
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_en
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_dir
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_ire
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_lt_1k
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/irq
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_next
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_en_next
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_dir_next
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_ire_next
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/counter_lt_1k_next
add wave -noupdate -expand -group peripheral_core /peripheral_tb/dut/peripheral_core/irq_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99700 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 328
configure wave -valuecolwidth 211
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
WaveRestoreZoom {0 ps} {509 ns}
