class memory_scoreboard;
memory_stimulus rec_pkt,exp_pkt;
bit[7:0] que2[$];
bit[7:0] data_in; 
int q_size;
	function new(mailbox exp_mail,mailbox rec_mail);
		rec_pkt=new();
		exp_pkt=new();
		fork
			capture_packets(exp_mail,rec_mail);
		join_none
		$display("scb created");
	endfunction
	task capture_packets(mailbox exp_mail,rec_mail);
		forever begin
			fork
				begin
				exp_mail.get(exp_pkt);
				end
				rec_mail.get(rec_pkt);
			join
			$display("%t packets %p",$time,rec_pkt);
			$display("%t exp packets %p",$time,exp_pkt);
			q_size=que2.size();
			if (exp_pkt.reset==0)begin
				if(rec_pkt.write_enable==1) begin
					que2.push_front(exp_pkt.data_in);
				end
				else if (rec_pkt.write_enable==0 && q_size>0)begin
					data_in=que2.pop_back();
					if (data_in==rec_pkt.data_out)begin
						$display("%t read/write test passed",$time);
					end
					else begin 
						$display("%t read/write test failed",$time);
					end
				end	
				else begin
					$display("memory is empty");
				end
			end
			else if (exp_pkt.reset==1) begin
				if (rec_pkt.data_out==0) begin
					$display("%t reset test pass",$time);
				end
				else begin
					$display("%t reset test fail",$time);
				end
			end
		end
	endtask	
endclass