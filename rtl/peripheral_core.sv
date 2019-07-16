

module peripheral_core(
    peripheral_register_interface.in  reg_io,
    output  logic                     irq_out
    );

    // this is a known value in this case because it is inside the core, so we preset it correctly.
    parameter REGS             = 3;
    parameter POWEROF2REGS     = $clog2(REGS) ** 2;
    parameter ADDRESSWIDTH     = $clog2(REGS);

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
    logic          irq;            // interrupt request


    // other internal logic signals
    logic  [31:0]  counter_next;
    logic          counter_en_next;
    logic          counter_dir_next;
    logic          counter_ire_next;
    logic          counter_lt_1k_next;
    logic          irq_next;


    // register block
    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin
        if(reg_io.reset) begin
            // reset conditions
            counter        <= 32'b0;
            counter_en     <= 1'b0;
            counter_dir    <= 1'b0;
            counter_ire    <= 1'b0;
            counter_lt_1k  <= 1'b0;
            irq            <= 1'b0;
        end else begin
            // default conditions
            counter        <= counter_next;
            counter_en     <= counter_en_next;
            counter_dir    <= counter_dir_next;
            counter_ire    <= counter_ire_next;
            counter_lt_1k  <= counter_lt_1k_next;
            irq            <= irq_next;
        end
    end


    // combinational logic block
    always_comb begin
        // default logic values
        reg_io.data_out     = '{POWEROF2REGS{32'b0}};            // set all output lines to zero
        irq_next            = 1'b0;                              // do not signal an interrupt
        counter_next        = counter;                           // retain old count value
        counter_en_next     = counter_en;                        // retain old data
        counter_dir_next    = counter_dir;                       // retain old data
        counter_ire_next    = counter_ire;                       // retain old data
        counter_lt_1k_next  = counter_lt_1k;                     // retain old data


        // counter logic
        if(reg_io.write_en[COUNT_REG])
            counter_next = reg_io.data_in[COUNT_HIGH:COUNT_LOW]; // load new count from bus master
        else begin
            if(counter_en) begin                                 // if counting is enabled then
                if(counter_dir)
                    counter_next = counter + 32'd1;              // count up
                else
                    counter_next = counter - 32'd1;              // count down
            end
        end


        // config logic
        if(reg_io.write_en[CONFIG_REG]) begin
            counter_en_next  = reg_io.data_in[COUNT_EN_HIGH:COUNT_EN_LOW];   // load new config value from bus master
            counter_dir_next = reg_io.data_in[COUNT_DIR_HIGH:COUNT_DIR_LOW]; // load new config value from bus master
            counter_ire_next = reg_io.data_in[COUNT_IRE_HIGH:COUNT_IRE_LOW]; // load new config value from bus master
        end


        // status logic
        counter_lt_1k_next = counter < 1000;                     // set the less than 1000 status flag if the count is less than 1000


        // interrupt triggering logic
        if(counter_ire && &counter[15:0])                        // trigger an interrupt if interrupts are enabled and
            irq_next = 1'b1;                                     // the lower 16 bits of the counter are set


        // assign output values
        reg_io.data_out[COUNT_REG] [COUNT_HIGH:COUNT_LOW]             = counter;
        reg_io.data_out[CONFIG_REG][COUNT_EN_HIGH:COUNT_EN_LOW]       = counter_en;
        reg_io.data_out[CONFIG_REG][COUNT_DIR_HIGH:COUNT_DIR_LOW]     = counter_dir;
        reg_io.data_out[CONFIG_REG][COUNT_IRE_HIGH:COUNT_IRE_LOW]     = counter_ire;
        reg_io.data_out[STATUS_REG][COUNT_LT_1K_HIGH:COUNT_LT_1K_LOW] = counter_lt_1k;
        irq_out                                                       = irq;

    end

endmodule

