class memory_test;
memory_environment environment;

	function new(virtual memory_interface intf);
		environment=new(intf);
		$display("test created");
	endfunction	
	task run_phase();
		environment.agent.driver.reset();
		environment.agent.driver.write(3,20);
		environment.agent.driver.read(3);
		for(int i=0;i<5;i++)begin
			environment.agent.driver.write(i,$urandom_range(30,0));
		end
		for(int i=0;i<5;i++)begin
			environment.agent.driver.read(i);
		end
		
	endtask
endclass