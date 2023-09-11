class memory_driver;
	memory_stimulus exp_pkt;
	virtual memory_interface intf;
	function new(virtual memory_interface intf,mailbox exp_mail);
		this.intf=intf;
		fork
		driver_capture(exp_mail);
		join_none
		$display("driv created");
	endfunction
	task driver_capture(mailbox exp_mail);
		forever begin
			@(negedge intf.clk);
			exp_pkt=new();
			exp_pkt.reset=intf.reset;    
			exp_pkt.addr=intf.addr;
			exp_pkt.write_enable=intf.write_enable;
            exp_pkt.data_in=intf.data_in;
            exp_pkt.data_out=intf.data_out;
			exp_mail.put(exp_pkt);
		end
	endtask
	task reset();
		intf.reset<=0;
		@(negedge intf.clk);		
		intf.addr<=0;
		intf.write_enable<=0;
		intf.data_in<=0;
		intf.reset<=1;
		@(negedge intf.clk);
		intf.reset<=0;
	endtask
	task read(bit[2:0] addr);
		@(negedge intf.clk);
		intf.write_enable<=0;
		intf.addr<=addr;
	endtask
	
	task write(bit[2:0] addr,[7:0] data_in);		
		@(negedge intf.clk);
		intf.write_enable<=1;
		intf.addr<=addr;
		intf.data_in<=data_in;
	endtask
endclass