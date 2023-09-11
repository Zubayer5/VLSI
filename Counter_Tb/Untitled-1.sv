module time_consume;
 `timesclae 1ns/100ps
function fun();
	fork
		#100;
		$display("It Works");
	join-none;
 	
endfunction