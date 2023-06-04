//-------Self checking TESTBENCH ----ARRAY SIGNED MULTIPLIER-----
//------Written by Bhanu Prakash-------

module Array_MUL_USign_TB( );


parameter M=8,N=8;

reg [N-1:0]A;
reg [M-1:0]B;
reg sg;
wire [N+M-1:0]Y;



//---- Instantiation of main test module----
Array_MUL_USign #(.N(N),.M(M)) UUT(.A(A),.B(B),.Y(Y));


// initializing the inputs to the test module
initial
repeat(50)
begin
#10 A = $random; B = $random; sg =$random;
#100//give required simulation time to complete the operation one by one.
#100
#10
//-----VERIFICATION OF THE OBTAINED RESULT WITH EXISTING RESULT------

	$display(" A=%d,B=%d,sg=%d,Y=%d",A,B,sg,Y);

	if( A*B != Y) // logic verification.
		$display(" *ERROR* ");

end



endmodule