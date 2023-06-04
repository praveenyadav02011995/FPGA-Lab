// EE20B007 Benstin Davis
`timescale 1ns / 1ps

module BCDto7Segment 
(
    input [3:0]in,
    output reg [7:0]out
);
    
always @(*) begin
    case (in)
        4'b0000 :
        out = ~8'b01111110;
        4'b0001 :
        out = ~8'b00110000;
        4'b0010 :
        out = ~8'b01101101;
        4'b0011 :
        out = ~8'b01111001;
        4'b0100 :
        out = ~8'b00110011;
        4'b0101 :
        out = ~8'b01011011;
        4'b0110 :
        out = ~8'b01011111;
        4'b0111 :
        out = ~8'b01110000;
        4'b1000 :
        out = ~8'b01111111;
        4'b1001 :
        out = ~8'b01111011;
    endcase
end
endmodule
