

module peripheral_core(
    peripheral_native_register_interface.in  reg_io,
    peripheral_memory_interface.in           mem_io,
    output  logic                            irq_out
    );


    // device registers (state that can be seen by a bus master)
    logic  [31:0]  count;        // count value
    logic          count_en;     // count enable
    logic          count_dir;    // count direction
    logic          count_ire;    // count interrupt request enable
    logic          count_lt_1k;  // count less than 1000


    // hidden registers
    logic          irq;          // interrupt request


    // other internal logic signals
    logic  [31:0]  count_next;
    logic          count_en_next;
    logic          count_dir_next;
    logic          count_ire_next;
    logic          count_lt_1k_next;
    logic          irq_next;


    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin : register_logic
        if(reg_io.reset) begin
            // reset conditions
            count        <= 32'b0;
            count_en     <= 1'b0;
            count_dir    <= 1'b0;
            count_ire    <= 1'b0;
            count_lt_1k  <= 1'b0;
            irq          <= 1'b0;
        end else begin
            // default conditions
            count        <= count_next;
            count_en     <= count_en_next;
            count_dir    <= count_dir_next;
            count_ire    <= count_ire_next;
            count_lt_1k  <= count_lt_1k_next;
            irq          <= irq_next;
        end
    end


    always_comb begin : combinational_logic
        // default logic values
        irq_next          = 1'b0;                  // do not signal an interrupt
        count_next        = count;                 // retain old count value
        count_en_next     = count_en;              // retain old data
        count_dir_next    = count_dir;             // retain old data
        count_ire_next    = count_ire;             // retain old data
        count_lt_1k_next  = count_lt_1k;           // retain old data


        // count logic
        if(reg_io.count_we)
            count_next = reg_io.count_in;          // load new count from bus master
        else begin
            if(count_en) begin                     // if counting is enabled then
                if(count_dir)
                    count_next = count + 32'd1;    // count up
                else
                    count_next = count - 32'd1;    // count down
            end
        end


        // config logic
        if(reg_io.count_config_we) begin
            count_en_next  = reg_io.count_en_in;   // load new config value from bus master
            count_dir_next = reg_io.count_dir_in;  // load new config value from bus master
            count_ire_next = reg_io.count_ire_in;  // load new config value from bus master
        end


        // status logic
        count_lt_1k_next = count < 1000;           // set the less than 1000 status flag if the count is less than 1000


        // interrupt triggering logic
        if(count_ire && &count[15:0])              // trigger an interrupt if interrupts are enabled and
            irq_next = 1'b1;                       // the lower 16 bits of the counter are set


        // assign output values
        reg_io.count_out       = count;
        reg_io.count_en_out    = count_en;
        reg_io.count_dir_out   = count_dir;
        reg_io.count_ire_out   = count_ire;
        reg_io.count_lt_1k_out = count_lt_1k;
        irq_out                = irq;

    end


    // instantiate a single port memory
    single_port_memory  #(.DATAWIDTH(32), .DATADEPTH(256))
    single_port_memory(
        .clk       (mem_io.clk),
        .write_en  (mem_io.write_en),
        .data_in   (mem_io.data_in),
        .address   (mem_io.address),
        .data_out  (mem_io.data_out)
    );


endmodule

