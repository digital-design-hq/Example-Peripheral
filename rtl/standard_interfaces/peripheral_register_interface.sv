

interface peripheral_register_interface;

    // this must be set on a per core basis
    parameter BUSWIDTH     = 32;
    parameter REGS         = 1;
    parameter POWEROF2REGS = $clog2(REGS) ** 2;
    parameter ADDRESSWIDTH = $clog2(REGS);


    // clocks and resets
    logic          clk;
    logic          reset;


    // device register lines
    logic  [BUSWIDTH-1:0]  data_in;
    logic  [BUSWIDTH-1:0]  data_out  [POWEROF2REGS-1:0];
    logic                  write_en  [POWEROF2REGS-1:0];
    logic                  read_en   [POWEROF2REGS-1:0];


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   data_in,
        output  data_out,
        input   write_en,
        input   read_en
    );


    modport out (
        output  clk,
        output  reset,
        output  data_in,
        input   data_out,
        output  write_en,
        output  read_en
    );

endinterface

