`timescale 1ns / 100ps


// this is just a simple testbench so you can visually inspect the waveforms of the peripheral, to run it fire up modelsim, change
// your directory to the sim folder of this project, then type "do run.do" without the quotes in the transcript window and hit enter.


module peripheral_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          reg_read;
    logic          reg_write;
    logic  [1:0]   reg_address;
    logic  [31:0]  reg_data_in;
    logic          mem_read;
    logic          mem_write;
    logic  [1:0]   mem_address;
    logic  [31:0]  mem_data_in;

    // output wires
    logic          reg_read_valid;
    logic  [31:0]  reg_data_out;
    logic          mem_read_valid;
    logic  [31:0]  mem_data_out;
    logic          irq;

    // extra wires needed for testing
    logic  [31:0]  data_in;
    logic  [31:0]  data_out;
    logic  [31:0]  address;
    logic          read;
    logic          write;
    logic          read_valid;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    peripheral_top
    dut(
        .clk,
        .reset,
        .reg_read,
        .reg_write,
        .reg_address     (address[3:2]),
        .reg_data_in     (data_in),
        .reg_read_valid,
        .reg_data_out,
        .mem_read,
        .mem_write,
        .mem_address     (address[9:2]),
        .mem_data_in     (data_in),
        .mem_read_valid,
        .mem_data_out,
        .irq
    );


    // extra logic needed to do the testing
    always_comb begin : test_logic
        // default
        reg_read  = 1'b0;
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;


        // read/write signal generation
        if(address >= 0 && address <= 15) begin
            if(read)  reg_read  = 1'b1;
            if(write) reg_write = 1'b1;
        end else if(address >= 1024 && address <= 2047) begin
            if(read)  mem_read  = 1'b1;
            if(write) mem_write = 1'b1;
        end


        // assign data_out
        case({mem_read_valid, reg_read_valid})
            2'b00: data_out = reg_data_out;
            2'b01: data_out = reg_data_out;
            2'b10: data_out = mem_data_out;
            2'b11: data_out = mem_data_out;
        endcase


        // set read_valid
        read_valid = reg_read_valid || mem_read_valid;
    end


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/
    int i;

    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        read           = 1'b0;
        write          = 1'b0;
        address        = 32'b0;
        data_in        = 32'd0;
    end


    // create clock sources
    always begin
        #5
        clk = 1'b0;
        #5
        clk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin

        // reset the system
        hardware_reset();

        // write counter
        write_data(32'd0, 32'd67);

        // read counter
        read_data(32'd0);

        // write config
        write_data(32'd4, 32'b11); // enable upward counting

        // read config
        read_data(32'd4);

        // read status
        read_data(32'd8);

        // read undefined address
        read_data(32'd12);

        // wait some time
        repeat(100000) @(posedge clk);

        // write config
        write_data(32'd4, 32'b111); // enable interrupts

        // wait some time
        repeat(100000) @(posedge clk);

        // write config
        write_data(32'd4, 32'b101); // enable downward counting

        // wait some time
        repeat(200000) @(posedge clk);

        // write 256 words to the peripheral memory
        i = 1024;

        repeat(256) begin
            write_data(i, i);
            i = i + 4;
        end

        // read all 256 words from the peripheral memory
        i = 1024;

        repeat(256) begin
            read_data(i);
            i = i + 4;
        end

        $stop;
     end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardware_reset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0;
    endtask


    task write_data(input logic [31:0] _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; data_in = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 32'd0;    data_in = 32'd0;
        end
    endtask


    task read_data(input logic [31:0] _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 32'd0;
            wait(read_valid);
        end
    endtask


endmodule

