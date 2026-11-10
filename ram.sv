module ram 
# (
    parameter ADDR_WIDTH = 32, 
    parameter DATA_WIDTH = 32, 
    parameter MEM_DEPTH_BYTES = 2048 // 0x0 to 0x7FF, which is 512 32-bit words
)
(
    input logic [ADDR_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0] data_out,
    input logic [3:0] byte_en, // byte enable signals for reading/writing specific bytes within a 32-bit word
                               // pattern should be 0001 (byte), 0011 (half), 1111 (word)
    input logic clk,
    input logic we,
    input logic [DATA_WIDTH-1:0] data_in
);

    // Simple read-only memory initialized with some values
    // iverilog does not support this System Verilog syntax, so need for loop
    // logic [DATA_WIDTH-1:0] rom [0:MEM_DEPTH-1] = '{default: '0};
    logic [7:0] ram [0:MEM_DEPTH_BYTES-1] ;

    localparam WORDS = MEM_DEPTH_BYTES / 4;  // if DATA_WIDTH isn't 32 this needs to be fixed
    reg [DATA_WIDTH:0] temp_word_mem [0:WORDS-1];

    // Initialize ROM with some values
    initial begin
        // initialize all locations to zero
        for (int i = 0; i < WORDS; i++) begin
            temp_word_mem[i] = 0; 
        end 
        // Distribute 32-bit words into 8-bit ROM slots
        for (int i = 0; i < WORDS; i = i + 1) begin
            // Little-endian mapping (adjust order if big-endian is needed)
            ram[i*4 + 0] = temp_word_mem[i][7:0];
            ram[i*4 + 1] = temp_word_mem[i][15:8];
            ram[i*4 + 2] = temp_word_mem[i][23:16];
            ram[i*4 + 3] = temp_word_mem[i][31:24];
        end
    end

    logic[1:0] addr10; 
    logic addr0;
    assign addr0 = addr[0];
    assign addr10 = addr[1:0];

    always_comb begin
        data_out = 32'b0;
        // Assumes program only accessing in a correctly aligned manner, but this will warn
        if (byte_en == 4'b0011 && addr0 != 0) begin
            $display("Warning: unaligned half-word access at address %h", addr);
        end else if (byte_en == 4'b1111 && addr10 != 0) begin
            $display("Warning: unaligned word access at address %h", addr);
        end

        case (byte_en)
            // byte
            4'b0001: data_out = {24'b0, ram[addr+0]}; 
            // half
            4'b0011: data_out = {16'b0, ram[addr+1], ram[addr+0]}; 
            // word
            4'b1111: data_out = {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr+0]};
            default: data_out = {32'b0};
        endcase
        if (we == 0 && byte_en != 0) begin
           $display("(%0d) RAM: Reading value %h from address %d with byte_en=%h", $time, data_out, addr, byte_en);
        end

    end


    // Sequential write logic (to support writing to this memory)
    always_ff @(posedge clk) begin
        if (we) begin
            $display("(%0d) RAM: Writing value %h to address %d with byte_en=%h", $time, data_in, addr, byte_en);

            // Write data_in to the appropriate locations in rom based on addr
            if (byte_en[0]) ram[addr+0] <= data_in[7:0];
            if (byte_en[1]) ram[addr+1] <= data_in[15:8];
            if (byte_en[2]) ram[addr+2] <= data_in[23:16];
            if (byte_en[3]) ram[addr+3] <= data_in[31:24];
        end
    end


endmodule
