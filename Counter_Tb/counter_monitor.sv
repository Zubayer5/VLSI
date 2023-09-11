class monitor;
virtual Counter_Interface intf;
mailbox mbx;
	function new(virtual Counter_Interface intf,mailbox mbx);
		$display("monitor working");
		this.intf=intf;
		this.mbx=new();
		this.mbx=mbx;
		fork
		monitor_capture(mbx);
		join_none
	endfunction

	task monitor_capture(mailbox mbx);
		counter_stimulus pkt;
		forever begin
			@(negedge intf.clk);
			pkt=new();
			pkt.data_in=intf.data_in;
			pkt.load=intf.load;
			pkt.enable=intf.enable;
			pkt.up_down=intf.up_down;
			pkt.reset=intf.reset;
			pkt.data_out=intf.data_out;
			$display("%0t MTCP Data:%p",$time,pkt);
			mbx.put(pkt);
		end
	endtask
endclass		