class memory_agent;
memory_monitor monitor;
memory_driver driver;
    function new(virtual memory_interface intf,mailbox rec_mail,exp_mail);
        monitor=new(intf,rec_mail);
        driver=new(intf,exp_mail);
		$display("agent created");
    endfunction
endclass