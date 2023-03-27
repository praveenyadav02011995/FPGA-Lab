`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:40:25 05/20/2022 
// Design Name: 
// Module Name:    ULTRASonicSensor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ULTRASonicSensor(input start, clk,reset,
input reset1,
output sel_disp1,sel_disp2,sel_disp3,sel_disp4,SIG_PD,
output en1, 
input echo, 
output [7:0] seg//,
//output [7:0] led
    );
wire [7:0] out,out0;
wire [23:0] out1;
wire [15:0] bin;
wire [18:0] bcd;
wire [31:0] p;
wire [23:0] count,led1;
parameter constant = 'h000004ad;
wire tc1,tc2,tc3,en2;

pg pga(start|tc2,tc1,clk,reset,en1);
count8 cnt1(out,8'b0,start|tc1,en1,reset,clk,tc1,8'd120);//according to 10us

pg pgb(tc1,tc2,clk,reset,en2);
count24 cnt2(out1,24'b0,start|tc2,en2,reset,clk,tc2,24'd3001200);//acoording to 250 ms

count24 cnt3(count,24'b0,tc1,echo,en1,clk,tc3,24'hffffff);
fdce16 fg(count,~echo,1'b1,led1);

SEVEN_SEGMENT seg2(clk,~reset1,sel_disp1,sel_disp2,sel_disp3,sel_disp4,SIG_PD,bcd[15:12],bcd[11:8],bcd[7:4],bcd[3:0],seg
    );
binbcd16 conv(led1[15:0]>>4,bcd);
endmodule

module pg(start,stop,clk,reset,q
    );
input clk,reset,start,stop;
output reg q;
always @ (posedge clk)
if(reset)
q <= 0;
else if(start)
q <= 1;
else if (stop)
q <= 0;
endmodule

module count8(out,data,load,en,reset,clk,tc,lmt);

output reg[7:0] out;

output reg tc;

input [7:0] data,lmt;

input load, en, clk,reset;

always @(posedge clk)

if (reset) begin

  out <= 8'b0 ;

end else if (en) begin

if (load)

  out <= data;

  else

  out <= out + 8'b00000001;

end

always @*

if (out ==lmt)

tc<=1;

else tc<=0;

endmodule


module count24(out,data,load,en,reset,clk,tc,lmt);

output reg[23:0] out;

output reg tc;

input [23:0] data,lmt;

input load, en, clk,reset;

always @(posedge clk)

if (reset) begin

  out <= 24'b0 ;

end else if (en) begin

if (load)

  out <= data;

  else

  out <= out + 1'b1;

end

always @*

if (out ==lmt)

tc<=1;

else tc<=0;

endmodule


module fdce16(a,clk,en,y);
	 input [23:0] a;
	 input clk,en;
	 output [23:0] y;
fdce d1(y[0],clk,en,a[0]);
fdce d2(y[1],clk,en,a[1]);
fdce d3(y[2],clk,en,a[2]);
fdce d4(y[3],clk,en,a[3]);
fdce d5(y[4],clk,en,a[4]);
fdce d6(y[5],clk,en,a[5]);
fdce d7(y[6],clk,en,a[6]);
fdce d8(y[7],clk,en,a[7]);
fdce d9(y[8],clk,en,a[8]);
fdce d10(y[9],clk,en,a[9]);
fdce d11(y[10],clk,en,a[10]);
fdce d12(y[11],clk,en,a[11]);
fdce d13(y[12],clk,en,a[12]);
fdce d14(y[13],clk,en,a[13]);
fdce d15(y[14],clk,en,a[14]);
fdce d16(y[15],clk,en,a[15]);
fdce d17(y[16],clk,en,a[16]);
fdce d18(y[17],clk,en,a[17]);
fdce d19(y[18],clk,en,a[18]);
fdce d20(y[19],clk,en,a[19]);
fdce d21(y[20],clk,en,a[20]);
fdce d22(y[21],clk,en,a[21]);
fdce d23(y[22],clk,en,a[22]);
fdce d24(y[23],clk,en,a[23]);
endmodule

module fdce(q,clk,ce,d);
    input d,clk,ce;
    output reg q;
initial begin q=0; end
always @ (posedge (clk)) begin
 if (ce)
  q <= d;
 else 
 q<= q ;
end
endmodule

module SEVEN_SEGMENT(
input clk,reset,
output reg sel_disp1,sel_disp2,sel_disp3,sel_disp4,
output SIG_PD,
input [3:0] data_disp_1,data_disp_2,data_disp_3,data_disp_4,output reg [6:0] DISP
    );
reg [15:0] COUNT;
reg [3:0] COUNT_BCD;
reg [3:0] BCD;
wire CLK_7_SIG;
always @ (posedge clk or  posedge reset)
begin
if (reset)
COUNT <= 0;
else 
COUNT <= COUNT + 1;
end

assign CLK_7_SIG = COUNT[14];

always @(posedge CLK_7_SIG or posedge reset)
begin
if (reset == 1 || BCD == 4'b0100)
BCD <= 0;
else 
BCD <= BCD + 1;
end

always @(posedge CLK_7_SIG )
begin
	case (BCD)
		3'b000 : begin
			sel_disp1 <= 1;
			sel_disp2 <= 0;
			sel_disp3 <= 0;
			sel_disp4 <= 0;
			//sel_disp5 <= 0;
			//sel_disp6 <= 0;
			COUNT_BCD <=data_disp_1; end
		3'b001 : begin
			sel_disp1 <= 0;
			sel_disp2 <= 1;
			sel_disp3 <= 0;
			sel_disp4 <= 0;
			//sel_disp5 <= 0;
			//sel_disp6 <= 0;
			COUNT_BCD <=data_disp_2; end
	
		3'b010 : begin
			sel_disp1 <= 0;
			sel_disp2 <= 0;
			sel_disp3 <= 1;
			sel_disp4 <= 0;
			//sel_disp5 <= 0;
			//sel_disp6 <= 0;
			COUNT_BCD <=data_disp_3; end
		3'b011 : begin
			sel_disp1 <= 0;
			sel_disp2 <= 0;
			sel_disp3 <= 0;
			sel_disp4 <= 1;
			//sel_disp5 <= 0;
			//sel_disp6 <= 0;
			COUNT_BCD <=data_disp_4; end
default : begin
			sel_disp1 <= 0;
			sel_disp2 <= 0;
			sel_disp3 <= 0;
			sel_disp4 <= 0;
			//sel_disp5 <= 0;
			//sel_disp6 <= 0;
			COUNT_BCD <=data_disp_1; end
	endcase end
	
	always @* begin
	case(COUNT_BCD)
	   4'b0000 : DISP =  7'b1000000;   //0
		4'b0001: DISP =  7'b1111001;   //1
		4'b0010 : DISP =  7'b0100100;  //2
		4'b0011 : DISP =  7'b0110000;    //3
		4'b0100 : DISP =  7'b0011001;   //4
		4'b0101 : DISP =  7'b0010010;  //5
		4'b0110 : DISP =  7'b0000010;    //6
		4'b0111 : DISP =  7'b1111000;   //7
		4'b1000 : DISP =  7'b0000000;   //8
		4'b1001 : DISP =  7'b0010000;    //9
		4'b1010 : DISP =  7'b0001000;    //A
		4'b1011 : DISP =  7'b0000011;    //b
		4'b1100 : DISP =  7'b1000110;    //C
		4'b1101 : DISP =  7'b0100001;   //d
		4'b1110 : DISP =  7'b0000110;    //E
		4'b1111 : DISP =  7'b0001110;    //F
   endcase end
assign SIG_PD = 1;
endmodule

 module binbcd16(B,P);
	input [15:0] B;
	output [18:0] P;

	reg [18:0] P;
	reg [35:0] z;
	integer i;



  always @(B)
  begin
    for(i = 0; i <= 35; i = i+1)
	z[i] = 0;
    z[18:3] = B;
    for(i = 0; i <= 12; i = i+1)
    begin
	if(z[19:16] > 4)	
		z[19:16] = z[19:16] + 3;
	if(z[23:20] > 4) 	
		z[23:20] = z[23:20] + 3;
	if(z[27:24] > 4) 	
		z[27:24] = z[27:24] + 3;
	if(z[31:28] > 4) 	
		z[31:28] = z[31:28] + 3;
		
		if(z[35:32] > 4) 	
		z[35:32] = z[35:32] + 3;
	
		
	z[35:1] = z[34:0];
	
	
	
    end      
    P = z[35:16];	
  end 
  
endmodule



