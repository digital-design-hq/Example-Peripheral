-suppress 2167
-suppress 7061

-sv 

../../../Part-Library/interfaces/register_interface.sv
../../../Part-Library/interfaces/memory_interface.sv
../../../Avalon-Adapter/rtl/avalon_register_adapter.sv
../../../Avalon-Adapter/rtl/avalon_memory_adapter.sv

../../../Part-Library/parts/simple_single_port_memory.sv
../../../Part-Library/parts/simple_dual_port_memory.sv
../../../Part-Library/parts/single_clock_fifo.sv

../../rtl/submodules/native_register_interface.sv
../../rtl/submodules/register_map.sv
../../rtl/submodules/native_core.sv

../../rtl/topmodules/avalon_example_peripheral.sv

avalon_example_peripheral_tb.sv

