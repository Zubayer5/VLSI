
module traffic_TOP(input wire reset,clk,
                   input wire start,
                   output r,
output g,
output y);
wire [3:0]  w;
wire [7:0] cn;
/*reg clk;

    always begin
        #1 clk<=1;
        clk<=0;
    end*/

    FSM_traffic FSM (.start(start),
                     .clk(clk),
                     .r(r),
                     .g(g),
                     .y(y),
                     .cou1(w[0]),
                     .cou2(w[1]),
                     .cou4(w[2]),
                     .en(w[3]),
                     .reset(reset));

    Counter cou(.en(w[3]),
                .reset(reset),
                .clk(clk),
                .count(cn));

    Comparetor comp(.clk(clk),
                    .count(cn),
                    .reset(reset),
                    .cou1(w[0]),
                    .cou2(w[1]),
                    .cou4(w[2]));

/*initial begin
    @(negedge clk); 
    start=1;
    $display("en=%0d,r=%0d,g=%0d,b=%0d",en,r,g,b);
    #10
    @(negedge clk);
    start=0;
    reset=1;
    $display("en=%0d,r=%0d,g=%0d,b=%0d",en,r,g,b);
end*/
endmodule
    



