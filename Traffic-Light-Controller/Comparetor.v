module Comparetor(input [7:0] count,
    input reset,clk,
    output reg cou1,cou2,cou4);

always@(posedge clk) begin
    if(count==20) begin
        cou2<=1;
        cou1<=0;
        cou4<=0;
    end
    else if (count==30) begin
        cou2<=0;
        cou1<=1;
        cou4<=0;
    end
    else if (count==70) begin
        cou2<=0;
        cou1<=0;
        cou4<=1;
    end
    else if (count==80) begin
        cou2<=0;
        cou1<=1;
        cou4<=0;
    end
end
endmodule