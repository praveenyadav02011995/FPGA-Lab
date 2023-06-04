// EE20B007 Benstin Davis
`timescale 1ns / 1ps

module BCDto7Segment 
(
    input [3:0]in,
    input point,
    output reg [7:0]out
);
    
always @(*) begin
    case (in)
        4'b0000 :
        out = {point,~7'b1111110};
        4'b0001 :
        out = {point,~7'b0110000};
        4'b0010 :
        out = {point,~7'b1101101};
        4'b0011 :
        out = {point,~7'b1111001};
        4'b0100 :
        out = {point,~7'b0110011};
        4'b0101 :
        out = {point,~7'b1011011};
        4'b0110 :
        out = {point,~7'b1011111};
        4'b0111 :
        out = {point,~7'b1110000};
        4'b1000 :
        out = {point,~7'b1111111};
        4'b1001 :
        out = {point,~7'b1111011};
    endcase
end
endmodule
