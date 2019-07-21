

module peripheral_top(
    input   logic          clk,
    input   logic          reset,

    input   logic          reg_read,
    input   logic          reg_write,
    input   logic  [1:0]   reg_address,
    input   logic  [31:0]  reg_data_in,
    output  logic          reg_read_valid,
    output  logic  [31:0]  reg_data_out,

    input   logic          mem_read,
    input   logic          mem_write,
    input   logic  [7:0]   mem_address,
    input   logic  [31:0]  mem_data_in,
    output  logic          mem_read_valid,
    output  logic  [31:0]  mem_data_out,

    output  logic          irq
    );


    // Interface parameters can only be set when an interface is
    // instantiated inside a module like below, they can't be set when
    // using them as a port on a module. As a result I didn't end
    // up making the avalon bus an interface because it's parameters
    // couldn't be set inside the peripheral only outside of it.
    // If anybody is aware of a way to do this feel free to change
    // the bus to an interface.
    peripheral_register_interface         #(.REGS(3))                         reg_adapter_io();
    peripheral_native_register_interface                                      reg_io();
    peripheral_memory_interface           #(.DATAWIDTH(32), .DATADEPTH(256))  mem_io();


    // instantiate the register adapter
    avalon_register_adapter #(.REGS(3), .LATENCY(1))
    avalon_register_adapter(
        .clk,
        .reset,
        .read        (reg_read),
        .write       (reg_write),
        .address     (reg_address),
        .data_in     (reg_data_in),
        .read_valid  (reg_read_valid),
        .data_out    (reg_data_out),
        .reg_io      (reg_adapter_io)
    );


    // instantiate the memory adapter
    avalon_memory_adapter #(.DATAWIDTH(32), .DATADEPTH(256), .LATENCY(1))
    avalon_memory_adapter(
        .clk,
        .reset,
        .read        (mem_read),
        .write       (mem_write),
        .address     (mem_address),
        .data_in     (mem_data_in),
        .read_valid  (mem_read_valid),
        .data_out    (mem_data_out),
        .mem_io
    );


    // instantiage the register map
    peripheral_register_map
    peripheral_register_map(
        .reg_adapter_io,
        .reg_io
    );


    // instantiate the peripheral core
    peripheral_core
    peripheral_core(
        .reg_io,
        .mem_io,
        .irq_out     (irq)
    );

endmodule

