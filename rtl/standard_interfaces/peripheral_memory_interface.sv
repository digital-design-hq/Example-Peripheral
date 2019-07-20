

interface peripheral_memory_interface;

    // this must be set on a per core basis
    parameter DATAWIDTH    = 1;
    parameter DATADEPTH    = 1;
    parameter ADDRESSWIDTH = $clog2(DATADEPTH);


    // clocks and resets
    logic          clk;
    logic          reset;


    // device memory lines
    logic  [ADDRESSWIDTH-1:0]  address;
    logic  [DATAWIDTH-1:0]     data_in;
    logic  [DATAWIDTH-1:0]     data_out;
    logic                      write_en;
    logic                      read_en;


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   address,
        input   data_in,
        output  data_out,
        input   write_en,
        input   read_en
    );


    modport out (
        output  clk,
        output  reset,
        output  address,
        output  data_in,
        input   data_out,
        output  write_en,
        output  read_en
    );

endinterface

