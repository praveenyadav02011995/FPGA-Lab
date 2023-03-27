//-------Self checking TESTBENCH ----ARRAY SIGNED MULTIPLIER-----
//------Written by Bhanu Prakash-------

module MAC_Array_MUL_Sign_TB( );


// Y =  C + AB  unsigned if sg = 0
// Y = C + AB signed is sg = 1


parameter La = 4, Lb = 4;
parameter Lc = La + Lb;
parameter Ly = La + Lb + 1; 

reg [La-1:0]A;
reg [Lb-1:0]B; 
reg [Lc-1:0]C;
reg sg; 

wire [Ly-1:0]Y; 



//---- Instantiation of main test module----

MAC_Array_MUL_Sign #(.La(La),.Lb(Lb), .Lc(Lc), .Ly(Ly)) UUT ( .A(A),.B(B),.C(C), .sg(sg),.Y(Y));

// initializing the inputs to the test module
initial
repeat(50)
begin
#10 A = $random; B = $random; C = $random; sg =$random;
#100//give required simulation time to complete the operation one by one.

//-----VERIFICATION OF THE OBTAINED RESULT WITH EXISTING RESULT------
if(sg == 1'b1)
begin
	$display("A = %d, B = %d,C = %d, sg = %d, Y = %d",$signed(A),$signed(B),$signed(C),sg,$signed(Y));

	if( $signed(C) + ($signed(A)*$signed(B)) != $signed(Y)) // logic verification.
		$display(" *ERROR* ");

end
else 
begin
	$display(" A=%d,B=%d,C= %d, sg=%d,Y=%d",A,B,C, sg,Y);

	if( C+ (A*B) != Y) // logic verification.
		$display(" *ERROR* ");
end

end



endmodule