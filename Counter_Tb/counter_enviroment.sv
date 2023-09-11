class environment;
scoreboard sb;
mailbox mbx;
agent ag;
	function new(virtual Counter_Interface intf);
		mbx=new();
		sb=new(mbx);
		ag=new(intf,mbx);
		$display("env working");
	endfunction
endclass
		