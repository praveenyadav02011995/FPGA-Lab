// Serial Adder for N = 8 bits inputs are unsigned adder 
// Full Adder, counter
// ---- Written by Vikramkumar Pudi ----

module ADD_SHIFT_MUL_Sign #(parameter N = 8, M = 8, logN = 4)(clk, start, rst, A, B, Y, MUL_done, MUL_aval, DOUT_aval);

input clk, rst, start; 
input [N-1:0] A;
input [M-1:0] B; 

output [N+M-1:0] Y;
output MUL_done, MUL_aval; 
output reg DOUT_aval;

///parameter logN = 4; // counter size 

reg [logN-1:0] count;

reg [N+M:0]ACC; // size of ACC is 1-bit higher than output Y


// M-bit Adder subtractor block 

// Acc[N+M:N] = Acc[N+M:N] + Sign XOR {B[M-1],B} + Sign; 
// Acc[0] = 1 only Acc[N+M:N] = Acc[N+M:N] + Sign XOR {B[M-1],B} + Sign; 
// else  Acc[N+M:N] = Acc[N+M:N]; 
wire [M+1:0]temp_ACC; 
reg [M:0] temp_B; 
reg Sign; 
Add_Sub_Nbit #(.N(M+1))  AS1 (.A(ACC[N+M:N]) , .B(temp_B) , .k(Sign), .S(temp_ACC) );


// Accumulator assigning value 

always@(posedge clk)
if (start==1'b0)
begin
	ACC <= 0;
end
else 
	
	if(count == 0)
	begin
		ACC[N+M:N] <= 0; 
		ACC[N-1:0] <= A;
	end
	else 	
		if( (count >0) & (count < N+2))
		begin  // ACC[N+M:N] = temp_ACC[M:0];
		       // ACC = {ACC[N+M], ACC[N+M:N], ACC[N-1:1]}; //right-shift
		       //ACC <= {temp_ACC[M],temp_ACC[M:0], ACC[N-1:1]}; //shifting the value 
			 ACC <= {temp_ACC, ACC[N-1:1]};
		end
		else 
			ACC <= ACC; 



// -- inputs to the ADD and SUB block START of inputs for ADDandSUB block ---

always@(posedge clk)
if (start==1'b0)
begin
	temp_B <= 0;
	Sign <= 1'b0;
end
else 	
begin
if( (count >0) & (count < N+1))  // Need to check for N-times count = 1 to N because A size N
	if(ACC[0] == 1'b1)
		temp_B <= {B[M-1],B};	
	else
		temp_B <= 0;

if(count == N)
	Sign <= 1'b1; 
else 
	Sign <= 1'b0;

end

// design counter, which will increment from 0 to N-1 

always@(posedge clk)
begin
if(rst == 1'b1)
begin 
	count <= 4'd0;
end
else 
begin 
	if(start == 1'b0) // intially start = 0 and 1 to do the opration
	begin
		count <= 4'd0; 
	end
	else
	begin
		if (count < N+2)
			count <= count + 1'b1;
		else 
			count <= count; 
	end

end

end


//---------- End of the counter module -------------------

// start of done module 

//always@(posedge clk)
//if (count < N+2)
//	MUL_done <= 1'b0;
//else 
//	MUL_done <= 1'b1; 
// END of done module 


// Output value 

assign Y = (count == N+2)?ACC[N+M-1:0]:0; 
assign MUL_done = (count == N+2)?1'b1:1'b0;




// Start of Adder_aval module 

//always@(posedge clk)
//if((rst == 1'b1) || (start == 1'b0) || (count == N))
//	adder_aval <= 1'b1;
//
//else 
//	adder_aval <= 1'b0;

//-------- END ---------------



endmodule