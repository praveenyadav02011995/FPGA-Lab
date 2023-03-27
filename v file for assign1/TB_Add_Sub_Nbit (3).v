// Test bench for Add_Sub_Nbit.v 
// Written by Dr. Vikram ----

module TB_Add_Sub_Nbit();

parameter M = 64; // Test vectors size is 2^64 x 2^64 x 2 = 2^129

reg [M-1:0]a, b; 
reg s; 

wire [M:0]Y;

 
Add_Sub_Nbit #(.N(M))  UUT (.A(a) , .B(b) , .k(s), .S(Y) );

initial begin

repeat(50)
begin
#10 a = $random; b = $random; s = $random; 
#100 // 100 units delay 
$display("a=%d,b=%d,s=%d,Sum=%d",$signed(a),$signed(b),s,$signed(Y));
end

$stop;
end

endmodule 