//Written by Dr. Vikram 

module MUX_4in_Nbit #(parameter N = 4)(A,B,C,D,s1, s0 , y);

input [N-1:0]A,B,C,D;
input s0, s1;

output [N-1:0]y;

wire [N-1:0]f1,f2;

 MUX_2in_Nbit  #(.N(N)) MUX2_AB (.a(A),
			.b(B),
			.s(s0),
			.y(f1));



 MUX_2in_Nbit  #(.N(N)) MUX2_CD(.a(C),
			.b(D),
			.s(s0),
			.y(f2));



 MUX_2in_Nbit  #(.N()) MUX2_f1f2 (.a(f1),
			.b(f2),
			.s(s1),
			.y(y));


endmodule 