onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/clk
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reset
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_read
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_write
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_address
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_data_in
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_read_valid
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/reg_data_out
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_read
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_write
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_address
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_data_in
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_read_valid
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/mem_data_out
add wave -noupdate -expand -group peripheral_top /avalon_example_peripheral_tb/dut/irq
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/clk
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/reset
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/read
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/write
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/address
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_in
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/read_valid
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_out
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/read_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/write_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/address_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_in_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_out_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/read_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/write_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/address_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_in_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/data_out_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/read_en
add wave -noupdate -expand -group avalon_register_adapter /avalon_example_peripheral_tb/dut/avalon_register_adapter/write_en
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/clk
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/reset
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/read
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/write
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/address
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/data_in
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/read_valid
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/data_out
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/valid
add wave -noupdate -expand -group avalon_memory_adapter /avalon_example_peripheral_tb/dut/avalon_memory_adapter/valid_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/irq_out
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/count
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/en
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/dir
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/ire
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/lt_1k
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/irq
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/count_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/en_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/dir_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/ire_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/lt_1k_next
add wave -noupdate -expand -group native_core /avalon_example_peripheral_tb/dut/native_core/irq_next
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/clk
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/write_en
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/data_in
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/address
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/data_out
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/address_reg
add wave -noupdate -expand -group simple_single_port_memory /avalon_example_peripheral_tb/dut/native_core/simple_single_port_memory/memory_block
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/clk
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/reset
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/write_en
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/read_req
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/data_in
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/data_out
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/word_count
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/empty
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/full
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/write_pointer
add wave -noupdate -expand -group single_clock_fifo /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/read_pointer
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/clk
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/write_en
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/data_in
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/read_address
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/write_address
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/data_out
add wave -noupdate -expand -group fifo_memory /avalon_example_peripheral_tb/dut/native_core/single_clock_fifo/simple_dual_port_memory/memory_block
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9083000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 585
configure wave -valuecolwidth 224
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
WaveRestoreZoom {2075116400 ps} {2103597900 ps}
