

module avalon_register_adapter
    #(parameter REGS         = 1,
      parameter POWEROF2REGS = $clog2(REGS) ** 2,
      parameter ADDRESSWIDTH = $clog2(REGS))(
    input                              logic                      clk,
    input                              logic                      reset,
    input                              logic                      read,
    input                              logic                      write,
    input                              logic  [ADDRESSWIDTH-1:0]  address,
    input                              logic  [31:0]              data_in,
    output                             logic                      read_valid,
    output                             logic  [31:0]              data_out,
    peripheral_register_interface.out                             reg_io
    );


    // internal logic signals
    logic  [ADDRESSWIDTH-1:0]  reg_address; // registered address from the previous cycle


    // register block
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            reg_address <= {ADDRESSWIDTH{1'b0}};
            read_valid  <= 1'b0;
        end else begin
            reg_address <= address;
            read_valid  <= read;
        end
    end


    // combinational logic block
    always_comb begin
        // default values
        reg_io.write_en = '{POWEROF2REGS{1'b0}};
        reg_io.read_en  = '{POWEROF2REGS{1'b0}};


        // generate device register read/write signals
        if(write) reg_io.write_en[address] = 1'b1;
        if(read)  reg_io.read_en[address]  = 1'b1;


        // assign data_out to device register at registered address
        data_out = reg_io.data_out[reg_address];


        // other assignments
        reg_io.clk     = clk;
        reg_io.reset   = reset;
        reg_io.data_in = data_in;
    end


endmodule

