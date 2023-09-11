/*clk: Clock signal for synchronous operations.
reset: Reset signal for initializing memory contents to all zeros.
addr: 3-bit address input to select the memory location.
write_enable: Write enable signal for indicating a write operation.
data_in: 8-bit data input for write operations.
Outputs:

data_out: 8-bit data output read from the selected memory location.
Behavior:

The memory module has eight memory locations, each storing an 8-bit value.
It supports both read and write operations.
On a positive edge of the clock (clk), the module updates the memory contents based on the write enable signal (write_enable), the address (addr), and the
 reset signal (reset).
When reset is asserted, the memory contents are reset to all zeros.
When write_enable is asserted and the clock edge occurs, the data provided at data_in is written to the memory location indicated by the addr.
During the clock edge, if write_enable is not asserted, the memory contents remain unchanged.
The selected memory location's data is available at the data_out output, regardless of whether a read or write operation occurs.
Note: The reset functionality has been added to the RTL and specifications to allow initialization of the memory contents to all zeros. This can be helpful 
during startup or when a system-wide reset is required.*/
module memory_8x8_faulty_read (
    input wire clk,
    input wire reset,
    input wire [2:0] addr,
    input wire write_enable,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

    reg [7:0] mem[0:7];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset memory to all zeros
            for (int i = 0; i < 8; i = i + 1)
                mem[i] <= 8'b00000000;
        end else begin
            if (write_enable)
                mem[addr] <= data_in;
        end
    end

    // Intentional fault in reading
    assign data_out = mem[addr + 1];

endmodule







