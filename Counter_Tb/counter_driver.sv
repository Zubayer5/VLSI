class driver;
virtual Counter_Interface intf;
	function new(virtual Counter_Interface intf);
		$display("driver working");	
		this.intf=intf;
		
	endfunction
	task reset();
		intf.reset<=1;		
		intf.up_down<=0;
		intf.data_in<=0;
		intf.enable<=0;
		intf.load<=0;
		@(negedge intf.clk);
		intf.reset<=0;
		@(negedge intf.clk);
		intf.reset<=1;
	endtask
	
	 task up_down(bit up_down_control);	 
			intf.enable<=1;
			intf.up_down<=up_down_control;			
		@(negedge intf.clk);
		intf.enable<=0;
	endtask
	
	task load(int data_in=0);
		intf.data_in<=data_in;
		intf.load<=1;
		intf.enable<=1;
		@(negedge intf.clk);
		intf.enable<=0;
		intf.load<=0;
	endtask
endclass
		