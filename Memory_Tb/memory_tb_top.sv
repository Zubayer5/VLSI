`timescale 1ns/1ps
module memory_tb_top;
    import memory_package::*;
    //Clock Generator
    bit clk;
    always #10 clk=~clk;
    //Interface
    memory_interface intf(clk);
    //Instanciate Module
    memory_8x8_reset DUT(.data_in(intf.data_in),
							.data_out(intf.data_out),
							.reset(intf.reset),
							.write_enable(intf.write_enable),
							.clk(clk),
							.addr(intf.addr));
	//Create test handle
	memory_test test;
    //Initiate test
	initial begin		
		test=new(intf);
		test.run_phase();
	end
	initial begin
		repeat(40) @(negedge clk);
		$finish;
	end
endmodule
