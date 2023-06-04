
module TB_ADD_SHIFT_MUL_Sign;

parameter N = 4, M = 4, logN = 2+1; 

reg clk, rst, start; 
reg [N-1:0] A;
reg [M-1:0] B; 

wire[N+M-1:0] Y;
wire MUL_done, MUL_aval, DOUT_aval;


ADD_SHIFT_MUL_Sign #(.N(N), .M(M), .logN(logN)) UUT (clk, start, rst, A, B, Y, MUL_done, MUL_aval, DOUT_aval);

initial
begin 
clk  = 1'b1;
rst = 1'b1; 
start = 1'b0; 
A = 8'd89;
B = 8'd10;

#100 rst = 1'b0; 
#20 start = 1'b1; 

#200  start = 1'b0; 

A = -8'd89;
B = 8'd10;

#20 start = 1'b1;

#200 
repeat(50)
begin
if(MUL_done == 1'b1)
begin
#10	$display("A=%d,B=%d, AxB = %d",$signed(A),$signed(B),$signed(Y));

#10 start = 1'b0; 
 A = $random; B = $random; 
#10 start = 1'b1; 

#200;
end
end

$stop; 

end

always
#5 clk = ~clk; 



endmodule 