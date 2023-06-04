`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2023 00:04:36
// Design Name: 
// Module Name: TB_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_Top();
reg clk;
reg rst;
reg start;

wire done;
wire tx_out;

Top DUT (
    .clk(clk),
    .reset(rst),
    .start(start),
    .done(done),
    .tx_out(tx_out)
);

initial begin
    clk = 0;
    rst = 0;
    start = 0;
    #10;
    rst = 1;
    #10;
    rst = 0;
    #10;
    start = 1;
end

always #5 clk = ~clk;

endmodule
