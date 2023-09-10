`timescale 1ms/1ns
module traffic_tb();
reg start,reset;
wire r,y,g;
bit clk;
always begin
 #500 clk=~clk;
end

traffic_TOP DUT(.start(start),
                .reset(reset),
                .r(r),
                .y(y),
                .g(g),
                .clk(clk));

initial begin
    reset<=1;
    @(negedge clk); 
    start<=1;
    reset<=0;
/*    #80000
    @(negedge clk);
    start=0;
    reset=1;*/
end
initial begin
repeat(240) @(negedge clk);
$finish;
end
endmodule