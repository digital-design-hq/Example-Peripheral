

// This only works with a single block ram at a time, handling multiple block rams would be complex if they
// are of different size. I am not fully sure how to handle that with an array at this time. We might just
// have to do a full custom module if you have more than one memory block. This doesn't give the correct
// value if you do a write directly followed by a read, it gives old-data in that situation. More logic
// would be needed to achieve that. This also doesn't support byte write enable signals right now.


module avalon_memory_adapter
    #(parameter DATAWIDTH    = 1,
      parameter DATADEPTH    = 1,
      parameter LATENCY      = 1,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input                            logic                      clk,
    input                            logic                      reset,
    input                            logic                      read,
    input                            logic                      write,
    input                            logic  [ADDRESSWIDTH-1:0]  address,
    input                            logic  [31:0]              data_in,
    output                           logic                      read_valid,
    output                           logic  [31:0]              data_out,
    peripheral_memory_interface.out                             mem_io
    );


    logic  [LATENCY-1:0] valid;
    logic  [LATENCY:0]   valid_next;


    // register block
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            valid <= {LATENCY{1'b0}};
        else begin
            valid <= valid_next[LATENCY-1:0];
        end
    end


    // combinational logic block
    always_comb begin
        mem_io.clk      = clk;
        mem_io.reset    = reset;
        mem_io.read_en  = read;
        mem_io.write_en = write;
        mem_io.address  = address;
        mem_io.data_in  = data_in[DATAWIDTH-1:0];
        data_out        = {{32-DATAWIDTH{1'b0}}, mem_io.data_out};
        read_valid      = valid[LATENCY-1];

        valid_next      = {valid[LATENCY-1:0], read};
    end


endmodule

