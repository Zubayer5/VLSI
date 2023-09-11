

class scoreboard;
	function new();
    		$display("Scoreboard created");
  	endfunction
endclass
class monitor;
	function new();
		$display("Monitor created");
	endfunction
endclass
class driver;
	function new();
		$display("Driver created");
	endfunction
endclass
class agent;
	driver dv;
	monitor mon;
	function new();
		dv=new();
		mon=new();
		$display("Agent created");
	endfunction
endclass
class environment;
	scoreboard sb;
	agent ag;
	function new();
		sb=new();
		ag=new();
		$display("Environment created");
	endfunction
endclass
class test;
	environment env;
	function new();
		env=new();
		$display("Test created");
	endfunction
endclass
module Tb_TOP;
initial begin
	test t;
	t=new();
end
endmodule




