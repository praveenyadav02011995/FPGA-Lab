
module TB_MUX_4in_Nbit();
parameter N = 8;

reg [N-1:0]A,B,C,D;
reg [1:0]S;

wire [N-1:0]y;


MUX_4in_Nbit #(.N(N)) DUT ( .A(A),
			   .B(B),
			   .C(C),
			   .D(D),
			   .s1(S[1]), 
			   .s0(S[0]) , 
			   .y(y));

initial 
begin

A = 8'd1; B = 8'd2; C = 8'd3; D = 8'd4; 

S[1] = 0; S[0] = 0; 

#10 S[1] = 0; S[0] = 1; 

#10 S[1] = 1; S[0] = 0; 

#10 S[1] = 1; S[0] = 1; 


#10 A = 8'h80; B = 8'h40; C = 8'h20; D = 8'h10; 

S[1] = 0; S[0] = 0; 

#10 S[1] = 0; S[0] = 1; 

#10 S[1] = 1; S[0] = 0; 

#10 S[1] = 1; S[0] = 1; 

end 

endmodule;