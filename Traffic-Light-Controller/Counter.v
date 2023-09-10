module Counter(
	input wire en,
	input wire reset,
	input wire clk,
	output reg [7:0] count
);
always@(posedge clk)begin
	if(reset)begin
		count=8'b1;
	end
	else begin
		if(en)begin
			if(count==81) begin
				count=8'b1;
			end
			else begin
				count=count+1'b1;
			end
		end
		else begin
			count=count;
		end
	end
end
endmodule