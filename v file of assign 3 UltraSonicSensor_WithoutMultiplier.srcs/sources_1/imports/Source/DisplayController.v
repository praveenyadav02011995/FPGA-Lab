// EE20B007 Benstin Davis 
`timescale 1ns / 1ps

module DisplayController#(
    parameter N = 5 // Clock divider
)(
    input clk,
    input [12:0]in,
    output [7:0] Seven_Seg,
    output reg [3:0] digit
);

reg [3:0] num;
reg p;
wire rclk;
wire [15:0]BCD;
BinToBCD M0 (.in(in),.out(BCD));
BCDto7Segment M1 (.in(num),.point(p),.out(Seven_Seg));
Clock_Divider #(.CYCLES(N)) M2 (.clk(clk),.rclk(rclk)); 

initial begin
    digit = 1;
end


always @(posedge rclk) begin
    case (digit)
        4'b1000:begin 
            digit = 4'b0100;
            num = BCD[7:4];
            p = 0;
        end 
        
        4'b0100:begin 
            digit = 4'b0010;
            num = BCD[11:8];
            p = 1;
        end 
        
        4'b0010:begin 
            digit = 4'b0001;
            num = BCD[15:12];
            p = 1;
        end 
        4'b0001:begin 
            digit = 4'b1000;
            num = BCD[3:0];
            p = 1;
        end 
        default: begin
            digit = 4'b1000;
            num = 4'b1000;
        end 
    endcase
end
endmodule