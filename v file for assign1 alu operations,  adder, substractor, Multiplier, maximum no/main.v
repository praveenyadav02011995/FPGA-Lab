`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2023 18:57:18
// Design Name: 
// Module Name: module
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


module module(
module main(
input [4:0]a,
input [4:0]b,
input [1:0]sel,
output [9:0]c
 );
   
wire [9:0]mul;
wire [5:0]sum,sub;
wire [4:0]max;

comparator_2bit uut0 (.A(a),.B(b),.y(max));
Array_MUL_Sign uut1(.A(a),.B(b),.Y(mul));
Add_Sub_Nbit uut2 (.A(a),.B(b), .k(1), .S(sub));
Add_Sub_Nbit uut3 (.A(a),.B(b), .k(0), .S(sum));

assign c = sel[1] ? (sel[0]? {{5{max[4]}},max} : mul):(sel[0] ? {{4{sub[5]}},sub} : {{4{sum[5]}},sum} );

endmodule


    );
endmodule
