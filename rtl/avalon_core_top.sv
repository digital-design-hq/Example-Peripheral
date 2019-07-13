

// register map
// address //   bits    //  registers       // type   //  access type  // value meaning
//       0      [31:0]      counter            data       read/write
//       1      [0]         count enable       config     read/write    (1 for enable, 0 for disable)
//       1      [1]         count direction    config     read/write    (1 for up,     0 for down)
//       1      [2]         count int enable   config     read/write    (1 for enable, 0 for disable)
//       2      [0]         count < 1000       status     read only     (1 for yes,    0 for no)


module avalon_core_top(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [1:0]   address,
    input   logic  [31:0]  data_in,
    output  logic          read_valid,
    output  logic  [31:0]  data_out,
    output  logic          irq
    );


    // Interface parameters can only be set when an interface is
    // instantiated inside a module like below, they can't be set when
    // using them as a port on a module. As a result I didn't end
    // up making the avalon bus an interface because it's parameters
    // couldn't be set inside the peripheral only outside of it.
    // If anybody is aware of a way to do this feel free to change
    // the bus to an interface.
    core_io    #(.REGS(3))  core_io();


    // instantiate the bus adapter
    avalon_adapter #(.REGS(3))
    avalon_adapter(
        .clk,
        .reset,
        .read,
        .write,
        .address,
        .data_in,
        .read_valid,
        .data_out,
        .irq,
        .core_io
    );


    // instantiate the core
    core
    core(
        .io       (core_io)
    );


endmodule

