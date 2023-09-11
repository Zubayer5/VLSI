class test;
environment e;
	function new(virtual Counter_Interface intf);
		e=new(intf);
	endfunction
	task run_phase();
		e.ag.dv.reset();	
		repeat(2) e.ag.dv.load(65535);
		e.ag.dv.up_down(1);
		e.ag.dv.load(0);
		repeat(3)e.ag.dv.up_down(1);
		repeat(5)e.ag.dv.up_down(0);
		e.ag.dv.reset();
		e.ag.dv.up_down(0);

	endtask
endclass
		