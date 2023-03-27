`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:50 10/05/2012 
// Design Name: 
// Module Name:    uart_tx 
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
module uart_tx(
reset          ,
txclk          ,
ld_tx_data     ,
tx_data        ,
tx_enable      ,
tx_out         ,
tx_empty       
);

// Port declarations
input        reset          ; // to rst pin 
input        txclk          ; // set Baud rate as txclk clock frequency 
input        ld_tx_data     ; // load tx data to tx register when '1'
input  [7:0] tx_data        ; // tx data 8-bit data input
input        tx_enable      ; //  transmit when enable 
output       tx_out         ; // Serial port pin; goes to pin PACKAGE_PIN C4(nexys4) 
output       tx_empty       ; // give this pin to Spartan-3E LED
// Internal Variables 
reg [7:0]    tx_reg         ;
reg          tx_empty       ;
reg          tx_over_run    ;
reg [3:0]    tx_cnt         ; //counter
reg          tx_out         ; // serial output 


// UART TX Logic
always @ (posedge txclk or posedge reset)
if (reset) begin
  tx_reg        <= 0;
  tx_empty      <= 1;
  tx_over_run   <= 0;
  tx_out        <= 1; // default high 
  tx_cnt        <= 0;
end else begin
   if (ld_tx_data) begin//when 1
      if (!tx_empty) begin // when 0(not empty)
        tx_over_run <= 0;
      end else begin
        tx_reg   <= tx_data;// load tx_data when empty
        tx_empty <= 0;
      end
   end
   if (tx_enable && !tx_empty) begin// when clk is high and reg is not empty and tx_en is high
    
     tx_cnt <= tx_cnt + 1;
     if (tx_cnt == 0) begin
       tx_out <= 0;//start bit
     end
     if (tx_cnt > 0 && tx_cnt < 9) begin//8 bit data
        tx_out <= tx_reg[tx_cnt -1];// shifting and transmitting 
     end
     if (tx_cnt == 9) begin
       tx_out <= 1;// stop bit 1
       tx_cnt <= 0;
       //done <= 1'b0;
       tx_empty <= 1;// ready to take next data 
     end
   end
   if (!tx_enable) begin
     tx_cnt <= 0;
   end
end


endmodule
