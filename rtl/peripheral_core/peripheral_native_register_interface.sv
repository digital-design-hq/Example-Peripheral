

// a new version of this would be written for each peripheral core
interface peripheral_native_register_interface;


    // clocks and resets
    logic          clk;
    logic          reset;


    // device register inputs
    logic  [31:0]  count_in;
    logic          en_in;
    logic          dir_in;
    logic          ire_in;


    // device register outputs
    logic  [31:0]  count_out;
    logic          en_out;
    logic          dir_out;
    logic          ire_out;
    logic          lt_1k_out;  // count is less than 1000 status output (read only)


    // device register control signals
    logic          count_we;   // counter register write enable
    logic          config_we;  // counter config register write enable


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   count_we,
        input   config_we,
        input   count_in,
        input   en_in,
        input   dir_in,
        input   ire_in,
        output  count_out,
        output  en_out,
        output  dir_out,
        output  ire_out,
        output  lt_1k_out
    );


    modport out (
        output  clk,
        output  reset,
        output  count_we,
        output  config_we,
        output  count_in,
        output  en_in,
        output  dir_in,
        output  ire_in,
        input   count_out,
        input   en_out,
        input   dir_out,
        input   ire_out,
        input   lt_1k_out
    );


endinterface

