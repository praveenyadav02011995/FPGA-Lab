`timescale 1ns / 1ps


module Top
# (
    parameter TX_TIME = 1000 // 1ms
)
(
    input clk,
    input start,
    input reset,
    output reg done,
    output tx_out
);

localparam IDLE = 3'b000;
localparam READ = 3'b001;
localparam WAIT = 3'b010;
localparam TX   = 3'b011;
localparam SEND = 3'b100;
localparam LOOP = 3'b101;
localparam DONE = 3'b110;
localparam BRAM_SIZE = 90000;

reg [2:0] curr_state = 0,next_state = 0;

wire [7:0] bram_data;
reg [16:0] bram_addr;

reg tx_en;
reg tx_ld;
reg inc = 0;

wire tx_empty;

Transmitter T0
(
    .clk(clk),
    .tx_enable(tx_en),
    .reset(reset),
    .ld_tx_data(tx_ld),
    .tx_data(bram_data),
    .tx_empty(tx_empty),
    .tx_out(tx_out)
);

blk_mem BRAM (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(bram_addr),  // input wire [16 : 0] addra
  .dina(8'd0),    // input wire [7 : 0] dina
  .douta(bram_data)  // output wire [7 : 0] douta
);


always @(posedge clk) begin
    if (reset) begin
        curr_state <= IDLE;
    end
    else begin
        curr_state <= next_state;
    end
    case (curr_state)
        IDLE: begin
            bram_addr = 0;
            tx_en = 0;
            tx_ld = 0;
            done = 0;
            if (start & !reset) begin
                next_state = READ;
            end
            else begin
                next_state = IDLE;
            end
        end
        READ: begin
            if (bram_addr == BRAM_SIZE) begin
                next_state = DONE;
            end
            else begin
                next_state = WAIT;
            end
        end
        WAIT: begin
            if (tx_empty) begin
                next_state = TX;
                tx_en = 1;
                tx_ld = 1;
            end
            else begin
                next_state = WAIT;
            end
        end
        TX: begin
            if(!tx_empty) begin
                next_state = SEND;
            end
        end
        SEND: begin
            if(tx_empty) begin
                next_state = LOOP;
                tx_en = 0;
                tx_ld = 0;
            end
            else begin
                next_state = SEND;
            end
        end
        LOOP: begin
            if(!inc)begin
                bram_addr = bram_addr + 1;
                inc = 1;            
            end
            else begin
                inc = 0;
            end
            next_state = READ;
        end
        DONE: begin
            done = 1;
        end
    endcase
end

endmodule
