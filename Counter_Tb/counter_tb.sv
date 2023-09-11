`timescale 1ns/1ps
module counter_tb;
import pac::*;
//Clock Generation
bit clk;

always #10 clk= ~clk;


//Insanciate interface
Counter_Interface intf(clk);

//Instanciate Design
counter DUT(.data_in(intf.data_in),
		.load(intf.load),
		.enable(intf.enable),
		.up_down(intf.up_down),
		.reset(intf.reset),
		.data_out(intf.data_out),
		.clk(clk));
//test instance 

initial begin
	test t1;
	t1=new(intf);
	t1.run_phase();
end
initial begin
repeat(40) @(negedge clk);
$finish;
end
endmodule