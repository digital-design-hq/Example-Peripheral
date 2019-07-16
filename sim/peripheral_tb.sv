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
    logic          read;
    logic          write;
    logic  [1:0]   address;
    logic  [31:0]  data_in;

    // output wires
    logic          read_valid;
    logic  [31:0]  data_out;
    logic          irq;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    peripheral_top
    dut(
        clk,
        reset,
        read,
        write,
        address,
        data_in,
        read_valid,
        data_out,
        irq
    );


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


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
        address        = 1'b0;
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
        write_data(2'd0, 32'd67);

        // read counter
        read_data(2'd0);

        // write config
        write_data(2'd1, 32'b11); // enable upward counting

        // read config
        read_data(2'd1);

        // read status
        read_data(2'd2);

        // read undefined address
        read_data(2'd3);

        // wait some time
        repeat(100000) @(posedge clk);

        // write config
        write_data(2'd1, 32'b111); // enable interrupts

        // wait some time
        repeat(100000) @(posedge clk);

        // write config
        write_data(2'd1, 32'b101); // enable downward counting

        // wait some time
        repeat(200000) @(posedge clk);

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


    task write_data(input logic [1:0] _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; data_in = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'd0;     data_in = 32'd0;
        end
    endtask


    task read_data(input logic [1:0] _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'd0;
            wait(read_valid);
        end
    endtask


endmodule

