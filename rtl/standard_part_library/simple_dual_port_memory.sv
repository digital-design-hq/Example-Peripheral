

module simple_dual_port_memory
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(

    input   logic                      clk,
    input   logic                      write_en,
    input   logic  [DATAWIDTH-1:0]     data_in,
    input   logic  [ADDRESSWIDTH-1:0]  read_address,
    input   logic  [ADDRESSWIDTH-1:0]  write_address,
    output  logic  [DATAWIDTH-1:0]     data_out
    );


    logic  [DATAWIDTH-1:0]  memory_block[DATADEPTH-1:0];


    // initialize to all 0's for simulation
    initial begin : init_logic
        integer i;
        for(i = 0; i < DATADEPTH; i++)
            memory_block[i] = {DATAWIDTH{1'b0}};
    end


    always_ff @(posedge clk) begin : memory_block_logic
        if(write_en)
            memory_block[write_address] <= data_in;

        data_out <= memory_block[read_address];
    end


endmodule

