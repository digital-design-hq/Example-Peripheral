

// interface definition
interface core_io;

    // this must be set on a per core basis
    parameter REGS = 1;


    // clocks and resets
    logic          clk;
    logic          reset;


    // device register lines
    logic  [31:0]  data_in;
    logic  [31:0]  data_out  [REGS-1:0];
    logic          write_en  [REGS-1:0];
    logic          read_en   [REGS-1:0];


    // interrupt request lines
    logic          irq_out;


    // modport list (used to define signal direction for specific situations)
    modport in (
        input   clk,
        input   reset,
        input   data_in,
        output  data_out,
        input   write_en,
        input   read_en,
        output  irq_out
    );


    modport out (
        output  clk,
        output  reset,
        output  data_in,
        input   data_out,
        output  write_en,
        output  read_en,
        input   irq_out
    );

endinterface


// core code
module core(
    core_io.in  io
    );

    // this is a known value in this case because it is inside the core, so we preset it correctly.
    parameter REGS             = 3;

    // reg maps
    parameter COUNT_REG        = 0;
    parameter CONFIG_REG       = 1;
    parameter STATUS_REG       = 2;

    // COUNT_REG bit map
    parameter COUNT_HIGH       = 31;
    parameter COUNT_LOW        = 0;

    // CONFIG_REG bit map
    parameter COUNT_EN_HIGH    = 0;
    parameter COUNT_EN_LOW     = 0;
    parameter COUNT_DIR_HIGH   = 1;
    parameter COUNT_DIR_LOW    = 1;
    parameter COUNT_IRE_HIGH   = 2;
    parameter COUNT_IRE_LOW    = 2;

    // STATUS_REG bit map
    parameter COUNT_LT_1K_HIGH = 0;
    parameter COUNT_LT_1K_LOW  = 0;


    // device registers
    logic  [31:0]  counter;        // counter value
    logic          counter_en;     // counter enable
    logic          counter_dir;    // counter direction
    logic          counter_ire;    // counter interrupt request enable
    logic          counter_lt_1k;  // counter less than 1000


    // hidden registers
    logic          counter_irq;    // counter interrupt request


    // other internal logic signals
    logic  [31:0]  counter_next;
    logic          counter_en_next;
    logic          counter_dir_next;
    logic          counter_ire_next;
    logic          counter_lt_1k_next;
    logic          counter_irq_next;


    // register block
    always_ff @(posedge io.clk or posedge io.reset) begin
        if(io.reset) begin
            // reset conditions
            counter        <= 32'b0;
            counter_en     <= 1'b0;
            counter_dir    <= 1'b0;
            counter_ire    <= 1'b0;
            counter_lt_1k  <= 1'b0;
            counter_irq    <= 1'b0;
        end else begin
            // default conditions
            counter        <= counter_next;
            counter_en     <= counter_en_next;
            counter_dir    <= counter_dir_next;
            counter_ire    <= counter_ire_next;
            counter_lt_1k  <= counter_lt_1k_next;
            counter_irq    <= counter_irq_next;
        end
    end


    // combinational logic block
    always_comb begin
        // default logic values
        io.data_out         = '{REGS{32'b0}};                // set all output lines to zero
        counter_irq_next    = 1'b0;                          // do not signal an interrupt
        counter_next        = counter;                       // retain old count value
        counter_en_next     = counter_en;                    // retain old data
        counter_dir_next    = counter_dir;                   // retain old data
        counter_ire_next    = counter_ire;                   // retain old data
        counter_lt_1k_next  = counter_lt_1k;                 // retain old data


        // counter logic
        if(io.write_en[COUNT_REG])
            counter_next = io.data_in[COUNT_HIGH:COUNT_LOW]; // load new count from bus master
        else begin
            if(counter_en) begin                             // if counting is enabled then
                if(counter_dir)
                    counter_next = counter + 32'd1;          // count up
                else
                    counter_next = counter - 32'd1;          // count down
            end
        end


        // config logic
        if(io.write_en[CONFIG_REG]) begin
            counter_en_next  = io.data_in[COUNT_EN_HIGH:COUNT_EN_LOW];   // load new config value from bus master
            counter_dir_next = io.data_in[COUNT_DIR_HIGH:COUNT_DIR_LOW]; // load new config value from bus master
            counter_ire_next = io.data_in[COUNT_IRE_HIGH:COUNT_IRE_LOW]; // load new config value from bus master
        end


        // status logic
        counter_lt_1k_next = counter < 1000;                 // set the less than 1000 status flag if the count is less than 1000


        // interrupt triggering logic
        if(counter_ire && &counter[15:0])                    // trigger an interrupt if interrupts are enabled and
            counter_irq_next = 1'b1;                         // the lower 16 bits of the counter are set


        // assign output values
        io.data_out[COUNT_REG] [COUNT_HIGH:COUNT_LOW]             = counter;
        io.data_out[CONFIG_REG][COUNT_EN_HIGH:COUNT_EN_LOW]       = counter_en;
        io.data_out[CONFIG_REG][COUNT_DIR_HIGH:COUNT_DIR_LOW]     = counter_dir;
        io.data_out[CONFIG_REG][COUNT_IRE_HIGH:COUNT_IRE_LOW]     = counter_ire;
        io.data_out[STATUS_REG][COUNT_LT_1K_HIGH:COUNT_LT_1K_LOW] = counter_lt_1k;
        io.irq_out                                                = counter_irq;

    end


endmodule

