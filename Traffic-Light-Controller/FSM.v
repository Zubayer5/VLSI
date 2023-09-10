
module FSM_traffic(input wire start,                                                                                                                                                                                                                                       
input wire reset,cou1,cou2,cou4,clk,
output reg r,
output reg g,
output reg y,
output reg en);
reg [1:0] pstate, nstate; 
reg dir; 

parameter
IDLE=2'b00,
Red=2'b01,
Yellow=2'b10,
Green=2'b11;
always@(*) begin 
	begin:NSL
	case (pstate)
		IDLE:begin
			if (start) begin
				nstate=Red;
			end
			else begin
				nstate=IDLE;
			end
		end
		Red:begin
			if (cou2) begin
				nstate=Yellow;
			end
			else begin
				nstate=Red;
			end
		end
		Yellow:begin
			if(cou1 && dir) begin
				nstate=Red;
			end
			else if(cou1) begin
				nstate=Green;
			end
			else begin
				nstate=Yellow;
			end
		end
		Green:begin
			if(cou4) begin
				nstate=Yellow;
			end
			else begin
				nstate=Green;
			end
		end
	endcase
	end

	begin:OL
	case(pstate)
		IDLE:begin
			r=1'b0;
			g=1'b0;
			y=1'b0;
			en=1'b0;
			$display("r=%0d,g=%0d,y=%0d,time=%t",r,g,y,$time);
		end
		Red:begin
			r=1'b1;
			g=1'b0;
			y=1'b0;
			dir=1'b0;
			en=1'b1;
			$display("r=%0d,g=%0d,y=%0d,time=%t",r,g,y,$time);
		end
		Yellow:begin
			r=1'b0;
			g=1'b0;
			y=1'b1;
			en=1'b1;
			$display("r=%0d,g=%0d,y=%0d,time=%t",r,g,y,$time);
		end
		Green:begin
			r=1'b0;
			g=1'b1;
			y=1'b0;
			dir=1'b1;
			en=1'b1;
			$display("r=%0d,g=%0d,y=%0d,time=%t",r,g,y,$time);
		end
		default:begin
			r=1'bx;
			g=1'bx;
			y=1'bx;
			dir=1'bx;
			en=1'bx;
			$display("r=%0d,g=%0d,y=%0d,time=%t",r,g,y,$time);
		end
	endcase
	end	
end
always@(posedge clk) begin
	begin:PSL
		if(~reset) begin
			pstate=nstate;
		end
		else begin
			pstate=IDLE;
		end
	end
end
endmodule
