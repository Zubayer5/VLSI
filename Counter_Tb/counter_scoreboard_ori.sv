class scoreboard;
	logic [15:0] prev_data;
counter_stimulus rec_pkt;
	function new(mailbox mbx);
			$display("sb working");
			fork
			scb_cap(mbx);
			join_none
	endfunction
	task scb_cap(mailbox mbx);
		forever begin
			mbx.get(rec_pkt);
			if(rec_pkt.reset==1)begin
				if(rec_pkt.enable==1 && rec_pkt.load==1)begin
					if(rec_pkt.data_in==rec_pkt.data_out)begin
						$display("@%t Load Test Pass",$time);
						
					end
					else begin
						$display("@%t Load Test Fail :: Exp Data:%0d Rec Data:%0d",$time,rec_pkt.data_in,rec_pkt.data_in);
					end
					prev_data=rec_pkt.data_out;
				end
				else if (rec_pkt.enable==1 && rec_pkt.up_down==1) begin
					if((prev_data+1)==rec_pkt.data_out && rec_pkt.data_out<65535)begin
						$display("@%t countup Test Pass",$time);
						prev_data=rec_pkt.data_in;
					end
					else begin
						if (rec_pkt.data_out>65535) begin
							$display("Overflow test Failed");	
						end
						else begin
						$display("@%t countup Test Fail :: Exp Data:%0d Rec Data:%0d",$time,(prev_data+1),rec_pkt.data_out);
						end
					end					
				end	
				else if (rec_pkt.enable==1 && rec_pkt.up_down==0) begin
					if((prev_data-1)==rec_pkt.data_out && rec_pkt.data_out>=0)begin
						$display("@%t countdown Test Pass",$time);
						prev_data=rec_pkt.data_in;
					end
					else begin
						if (rec_pkt.data_out<0) begin
							$display("Underflow test Failed");	
						end
						else
						$display("@%t countdown Test Fail :: Exp Data:%0d Rec Data:%0d",$time,(prev_data-1),rec_pkt.data_out);
					end					
				end	
			end
			else begin
				prev_data=0;
			end
			$display("%0t SCP Data:%p",$time,rec_pkt);
		end
	endtask
endclass
		