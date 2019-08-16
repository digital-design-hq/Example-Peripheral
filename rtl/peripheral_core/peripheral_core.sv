

module peripheral_core(
    peripheral_native_register_interface.in  reg_io,
    peripheral_memory_interface.in           mem_io,
    output  logic                            irq_out
    );


    // device registers (state that can be seen by a bus master)
    logic  [31:0]  count;  // count value
    logic          en;     // count enable
    logic          dir;    // count direction
    logic          ire;    // count interrupt request enable
    logic          lt_1k;  // count less than 1000


    // hidden registers
    logic          irq;    // interrupt request


    // other internal logic signals
    logic  [31:0]  count_next;
    logic          en_next;
    logic          dir_next;
    logic          ire_next;
    logic          lt_1k_next;
    logic          irq_next;


    always_ff @(posedge reg_io.clk or posedge reg_io.reset) begin : register_logic
        if(reg_io.reset) begin
            // reset conditions
            count  <= 32'b0;
            en     <= 1'b0;
            dir    <= 1'b0;
            ire    <= 1'b0;
            lt_1k  <= 1'b0;
            irq    <= 1'b0;
        end else begin
            // default conditions
            count  <= count_next;
            en     <= en_next;
            dir    <= dir_next;
            ire    <= ire_next;
            lt_1k  <= lt_1k_next;
            irq    <= irq_next;
        end
    end


    always_comb begin : combinational_logic
        // default logic values
        irq_next   = 1'b0;                      // do not signal an interrupt
        count_next = count;                     // retain old count value
        en_next    = en;                        // retain old data
        dir_next   = dir;                       // retain old data
        ire_next   = ire;                       // retain old data
        lt_1k_next = lt_1k;                     // retain old data


        // count logic
        if(reg_io.count_we)
            count_next = reg_io.count_in;       // load new count from bus master
        else begin
            if(en) begin                        // if counting is enabled then
                if(dir)
                    count_next = count + 32'd1; // count up
                else
                    count_next = count - 32'd1; // count down
            end
        end


        // config logic
        if(reg_io.config_we) begin
            en_next  = reg_io.en_in;            // load new config value from bus master
            dir_next = reg_io.dir_in;           // load new config value from bus master
            ire_next = reg_io.ire_in;           // load new config value from bus master
        end


        // status logic
        lt_1k_next = count < 1000;              // set the less than 1000 status flag if the count is less than 1000


        // interrupt triggering logic
        if(ire && &count[15:0])                 // trigger an interrupt if interrupts are enabled and
            irq_next = 1'b1;                    // the lower 16 bits of the counter are set


        // assign output values
        reg_io.count_out = count;
        reg_io.en_out    = en;
        reg_io.dir_out   = dir;
        reg_io.ire_out   = ire;
        reg_io.lt_1k_out = lt_1k;
        irq_out          = irq;

    end


    // instantiate a single port memory
    simple_single_port_memory  #(.DATAWIDTH(32), .DATADEPTH(256))
    simple_single_port_memory(
        .clk       (mem_io.clk),
        .write_en  (mem_io.write_en),
        .data_in   (mem_io.data_in),
        .address   (mem_io.address),
        .data_out  (mem_io.data_out)
    );


    // instantiate a single clock fifo
    single_clock_fifo  #(.DATAWIDTH(8), .DATADEPTH(256))
    single_clock_fifo(
        .clk        (reg_io.clk),
        .reset      (reg_io.reset),
        .write_en   (reg_io.fifo_we),
        .read_req   (reg_io.fifo_re),
        .data_in    (reg_io.fifo_data_in),
        .data_out   (reg_io.fifo_data_out),
        .word_count (reg_io.fifo_word_count),
        .empty      (reg_io.fifo_empty),
        .full       (reg_io.fifo_full)
    );


endmodule

