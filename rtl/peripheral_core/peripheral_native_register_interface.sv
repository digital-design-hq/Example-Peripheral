

// a new version of this would be written for each peripheral core
interface peripheral_native_register_interface;


    // clocks and resets
    logic          clk;
    logic          reset;


    // device register inputs
    logic  [31:0]  count_in;
    logic          count_en_in;
    logic          count_dir_in;
    logic          count_ire_in;


    // device register outputs
    logic  [31:0]  count_out;
    logic          count_en_out;
    logic          count_dir_out;
    logic          count_ire_out;
    logic          count_lt_1k_out;  // count is less than 1000 status output (read only)


    // device register control signals
    logic          count_we;         // counter register write enable
    logic          count_config_we;  // counter config register write enable


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   count_we,
        input   count_config_we,
        input   count_in,
        input   count_en_in,
        input   count_dir_in,
        input   count_ire_in,
        output  count_out,
        output  count_en_out,
        output  count_dir_out,
        output  count_ire_out,
        output  count_lt_1k_out
    );


    modport out (
        output  clk,
        output  reset,
        output  count_we,
        output  count_config_we,
        output  count_in,
        output  count_en_in,
        output  count_dir_in,
        output  count_ire_in,
        input   count_out,
        input   count_en_out,
        input   count_dir_out,
        input   count_ire_out,
        input   count_lt_1k_out
    );


endinterface

