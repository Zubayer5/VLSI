class agent;
driver dv;
monitor mon;
	function new(virtual Counter_Interface intf,mailbox mbx);
		dv=new(intf);
		mon=new(intf,mbx);
		$display("ag working");
	endfunction
endclass
		