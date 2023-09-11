interface memory_interface(input bit clk);
    logic reset;
    logic [2:0] addr;
    logic write_enable;
    logic [7:0] data_in;
	logic [7:0] data_out;
endinterface