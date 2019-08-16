

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
    logic   [7:0]  fifo_data_in;


    // device register outputs
    logic  [31:0]  count_out;
    logic          en_out;
    logic          dir_out;
    logic          ire_out;
    logic          lt_1k_out;  // count is less than 1000 status output (read only)
    logic          fifo_empty;
    logic          fifo_full;
    logic   [7:0]  fifo_word_count;
    logic   [7:0]  fifo_data_out;


    // device register control signals
    logic          count_we;   // counter register write enable
    logic          config_we;  // counter config register write enable
    logic          fifo_we;    // fifo write enable
    logic          fifo_re;    // fifo read enable


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   count_we,
        input   config_we,
        input   fifo_we,
        input   fifo_re,
        input   count_in,
        input   en_in,
        input   dir_in,
        input   ire_in,
        input   fifo_data_in,
        output  count_out,
        output  en_out,
        output  dir_out,
        output  ire_out,
        output  lt_1k_out,
        output  fifo_empty,
        output  fifo_full,
        output  fifo_word_count,
        output  fifo_data_out
    );


    modport out (
        output  clk,
        output  reset,
        output  count_we,
        output  config_we,
        output  fifo_we,
        output  fifo_re,
        output  count_in,
        output  en_in,
        output  dir_in,
        output  ire_in,
        output  fifo_data_in,
        input   count_out,
        input   en_out,
        input   dir_out,
        input   ire_out,
        input   lt_1k_out,
        input   fifo_empty,
        input   fifo_full,
        input   fifo_word_count,
        input   fifo_data_out
    );


endinterface

