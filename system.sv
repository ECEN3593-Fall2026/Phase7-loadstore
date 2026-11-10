module system (
    input logic clk,
    input logic reset
);

logic [31:0] instruction_address;
logic [31:0] instruction_data;

// instruction memory 
unclocked_ro_mem #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .MEM_DEPTH_BYTES(1024),
    .INIT_FILE("init.mem")
) instruction_memory (
    .addr(instruction_address),  // Example address, modify as needed
    .data_out(instruction_data)    // Connect to CPU or other module as needed
);

logic [31:0] data_address;
logic [31:0] data_readdata;
logic data_write_en;
logic [3:0] data_byte_en;
logic [31:0] data_writedata;


// data memory
ram #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .MEM_DEPTH_BYTES(2048) // 0x0 to 0x7ff
) data_mem (
    .clk(clk),
    .we(data_write_en),
    .addr(data_address),
    .data_in(data_writedata),
    .data_out(data_readdata),
    .byte_en(data_byte_en)

);

// cpu
    // Instantiate the CPU module
cpu cpu_inst (
        .clk(clk),
        .reset(reset),
        .instruction_data(instruction_data),
        .instruction_address(instruction_address),
        .data_address(data_address),
        .data_readdata(data_readdata),
        .data_write_en(data_write_en),
        .data_writedata(data_writedata),
        .data_byte_en(data_byte_en)
    );

endmodule
