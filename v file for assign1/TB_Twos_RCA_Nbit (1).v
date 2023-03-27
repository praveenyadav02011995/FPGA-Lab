// Test bench for Twos_RCA_Nbit.v 
// Written by Dr. Vikram ----

module TB_Twos_RCA_Nbit();

parameter M = 32;

reg [M-1:0]a, b; 
reg P; 

wire [M:0]Sum;

 
Twos_RCA_Nbit #(.N(M))  UUT (.A(a) , .B(b) , .cin(P), .S(Sum) );

initial begin

repeat(50)
begin
#10 a = $random; b = $random; P = $random; 
#100 // 100 units delay 
$display("a=%d,b=%d,P=%d,Sum=%d",$signed(a),$signed(b),P,$signed(Sum));
end

$stop;
end

endmodule 