class memory_monitor;
	memory_stimulus rec_pkt;
	virtual memory_interface intf;
	function new(virtual memory_interface intf,mailbox rec_mail);
		this.intf=intf;
		fork
		monitor_capture(rec_mail);
		join_none
		$display("monitor created");
	endfunction
	task monitor_capture(mailbox rec_mail);
		forever begin
			@(posedge intf.clk);
			rec_pkt=new();
			rec_pkt.reset=intf.reset;    
			rec_pkt.addr=intf.addr;
			rec_pkt.write_enable=intf.write_enable;
            rec_pkt.data_in=intf.data_in;
            rec_pkt.data_out=intf.data_out;
			rec_mail.put(rec_pkt);
			
		end
	endtask
endclass