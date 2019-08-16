

module single_clock_fifo
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input   logic                      clk,
    input   logic                      reset,
    input   logic                      write_en,
    input   logic                      read_req,
    input   logic  [DATAWIDTH-1:0]     data_in,
    output  logic  [DATAWIDTH-1:0]     data_out,
    output  logic  [ADDRESSWIDTH-1:0]  word_count,
    output  logic                      empty,
    output  logic                      full
    );


    //logic  [DATAWIDTH-1:0]  data_out_wire;
    logic  [ADDRESSWIDTH-1:0]  write_pointer;
    logic  [ADDRESSWIDTH-1:0]  read_pointer;


    assign empty = (word_count == 0);
    assign full  = (word_count == (DATADEPTH-1));


    always_ff @(posedge clk or posedge reset) begin : write_pointer_logic
        if(reset)
            write_pointer <= 0;
        else if(write_en)
            write_pointer <= write_pointer + {{ADDRESSWIDTH-1{1'b0}}, 1'b1};
        else
            write_pointer <= write_pointer;
    end


    always_ff @(posedge clk or posedge reset) begin : read_pointer_logic
        if(reset)
            read_pointer <= 0;
        else if(read_req)
            read_pointer <= read_pointer + {{ADDRESSWIDTH-1{1'b0}}, 1'b1};
        else
            read_pointer <= read_pointer;
    end


    always_ff @(posedge clk or posedge reset) begin : word_counter_logic
        if(reset)
            word_count <= 0;
        else if(read_req && !write_en)
            word_count <= word_count - {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // read but no write
        else if(write_en && !read_req)
            word_count <= word_count + {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // write but no read
        else
            word_count <= word_count;         // no change if read and write at the same time or no activity
    end


    /*always_ff @(posedge clk or posedge reset) begin : data_output_register_logic
        if(reset)
            data_out <= 8'd0;
        else if(read_req)
            data_out <= data_out_wire;
        else
            data_out <= data_out;
    end*/


    simple_dual_port_memory #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(DATADEPTH))
    simple_dual_port_memory(
        .clk,
        .write_en,
        .data_in,
        .read_address    (read_pointer),
        .write_address   (write_pointer),
        .data_out        //(data_out_wire)
    );


endmodule

