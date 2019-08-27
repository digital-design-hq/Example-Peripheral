

// register map
// address //   bits    //  registers       // type   //  access type  // value meaning
//       0      [31:0]      counter            data       read/write
//       1      [0]         count enable       config     read/write    (1 for enable, 0 for disable)
//       1      [1]         count direction    config     read/write    (1 for up,     0 for down)
//       1      [2]         count int enable   config     read/write    (1 for enable, 0 for disable)
//       2      [0]         count < 1000       status     read only     (1 for yes,    0 for no)
//       2      [1]         fifo empty         status     read only
//       2      [2]         fifo full          status     read only
//       2      [10:3]      fifo word count    status     read only     this tells how many words are in the fifo
//       3      [7:0]       fifo data in       data       write only
//       4      [7:0]       fifo data out      data       read only


module register_map(
    register_interface.in          reg_adapter_io,
    native_register_interface.out  reg_io
    );


    // this is a known value so we preset it correctly.
    parameter REGS             = 5;
    parameter POWEROF2REGS     = $clog2(REGS) ** 2;


    // assign resets and clocks
    assign reg_io.clk   = reg_adapter_io.clk;
    assign reg_io.reset = reg_adapter_io.reset;


    // map native registers to generic register array of bus adapter
    always_comb begin
        // defaults
        reg_adapter_io.data_out          = '{POWEROF2REGS{32'b0}};        // set all output lines to zero


        // counter register mapping
        reg_io.count_we                  = reg_adapter_io.write_en[0];    // write enable map
        reg_io.count_in                  = reg_adapter_io.data_in [31:0]; // input map
        reg_adapter_io.data_out[0][31:0] = reg_io.count_out;              // output map


        // config register mapping
        reg_io.config_we                 = reg_adapter_io.write_en[1];    // write enable map
        reg_io.en_in                     = reg_adapter_io.data_in [0];    // input map
        reg_io.dir_in                    = reg_adapter_io.data_in [1];    // input map
        reg_io.ire_in                    = reg_adapter_io.data_in [2];    // input map
        reg_adapter_io.data_out[1][0]    = reg_io.en_out;                 // output map
        reg_adapter_io.data_out[1][1]    = reg_io.dir_out;                // output map
        reg_adapter_io.data_out[1][2]    = reg_io.ire_out;                // output map


        // status register mapping
        reg_adapter_io.data_out[2][0]    = reg_io.lt_1k_out;              // output map
        reg_adapter_io.data_out[2][1]    = reg_io.fifo_empty;             // output map
        reg_adapter_io.data_out[2][2]    = reg_io.fifo_full;              // output map
        reg_adapter_io.data_out[2][10:3] = reg_io.fifo_word_count;        // output map


        // fifo data in mapping
        reg_io.fifo_we                   = reg_adapter_io.write_en[3];    // write enable map
        reg_io.fifo_data_in              = reg_adapter_io.data_in [7:0];  // input map


        // fifo data out mapping
        reg_io.fifo_re                   = reg_adapter_io.read_en[4];     // read enable map
        reg_adapter_io.data_out[4][7:0]  = reg_io.fifo_data_out;          // output map
    end


endmodule

