class memory_environment;
	memory_agent agent;
	memory_scoreboard scoreboard;
	mailbox exp_mail,rec_mail;
	function new(virtual memory_interface intf);
		rec_mail=new();
		exp_mail=new();
		agent=new(intf,exp_mail,rec_mail);
		scoreboard=new(exp_mail,rec_mail);
		$display("env created");
	endfunction
endclass