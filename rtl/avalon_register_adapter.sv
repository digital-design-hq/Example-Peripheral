

module avalon_register_adapter
    #(parameter REGS           = 1,
      parameter LATENCY        = 1,
      parameter ADDRESSLATENCY = ((LATENCY == 1) || (LATENCY == 2)) ? 1 : LATENCY - 1,
      parameter POWEROF2REGS   = $clog2(REGS) ** 2,
      parameter ADDRESSWIDTH   = $clog2(REGS))(
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


    // internal registers
    logic  [LATENCY:0]                             read_reg;
    logic  [LATENCY:0]                             write_reg;
    logic  [ADDRESSLATENCY:0][ADDRESSWIDTH-1:0]    address_reg;
    logic  [LATENCY:0][31:0]                       data_in_reg;
    logic  [LATENCY:0][31:0]                       data_out_reg;


    // internal logic signals
    logic  [LATENCY-1:0]                           read_reg_next;
    logic  [LATENCY-1:0]                           write_reg_next;
    logic  [ADDRESSLATENCY-1:0][ADDRESSWIDTH-1:0]  address_reg_next;
    logic  [LATENCY-1:0][31:0]                     data_in_reg_next;
    logic  [LATENCY-1:0][31:0]                     data_out_reg_next;
    logic                                          read_en;
    logic                                          write_en;


    // register block
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            read_reg[LATENCY:1]           <= {LATENCY{1'b0}};
            write_reg[LATENCY:1]          <= {LATENCY{1'b0}};
            address_reg[ADDRESSLATENCY:1] <= {ADDRESSLATENCY*ADDRESSWIDTH{1'b0}};
            data_in_reg[LATENCY:1]        <= {LATENCY*32{1'b0}};
            data_out_reg[LATENCY:1]       <= {LATENCY*32{1'b0}};
        end else begin
            read_reg[LATENCY:1]           <= read_reg_next;
            write_reg[LATENCY:1]          <= write_reg_next;
            address_reg[ADDRESSLATENCY:1] <= address_reg_next;
            data_in_reg[LATENCY:1]        <= data_in_reg_next;
            data_out_reg[LATENCY:1]       <= data_out_reg_next;
        end
    end


    // combinational logic block
    always_comb begin
        // default values
        reg_io.write_en = '{POWEROF2REGS{1'b0}};
        reg_io.read_en  = '{POWEROF2REGS{1'b0}};


        // generate device register read/write signals
        if(write_en) reg_io.write_en[address_reg[LATENCY-1]] = 1'b1;
        if(read_en)  reg_io.read_en[address_reg[LATENCY-1]]  = 1'b1;


        // control signal assignments
        read_reg[0]       = read;
        write_reg[0]      = write;
        read_reg_next     = {read_reg[LATENCY-1:0]};
        write_reg_next    = {write_reg[LATENCY-1:0]};
        read_en           = read_reg[LATENCY-1];
        write_en          = write_reg[LATENCY-1];
        read_valid        = read_reg[LATENCY];


        // address assignments
        address_reg[0]    = address;
        address_reg_next  = address_reg[ADDRESSLATENCY-1:0];


        // data in assignments
        data_in_reg[0]    = data_in;
        data_in_reg_next  = data_in_reg[LATENCY-1:0];
        reg_io.data_in    = data_in_reg[LATENCY-1];


        // data out assignments
        data_out_reg[0]   = reg_io.data_out[address_reg[ADDRESSLATENCY]];
        data_out_reg_next = data_out_reg[LATENCY-1:0];
        data_out          = data_out_reg[LATENCY-1];


        // other assignments
        reg_io.clk     = clk;
        reg_io.reset   = reset;
    end


endmodule

