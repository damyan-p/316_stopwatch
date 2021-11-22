`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2021 03:13:36 PM
// Design Name: 
// Module Name: tb_stopwatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_stopwatch;
reg clk;
reg P;
reg R;
reg [7:0] load;
reg [1:0] sel;
wire [3:0] an;
wire [6:0] sseg;
wire [1:0] cstateDb;

stopwatch_main u1(.clk(clk),.P(P),.R(R),.load(load),.sel(sel),.an(an),.sseg(sseg)
,.cstateDb(cstateDb)
);

initial
begin
P=0;
clk = 0;
load = 8'h99;
sel = 2'b00;
R = 0;
#10;
R = 1;
#200;
R = 0;
#100;
P = 1;
#5;
P = 0;  //  testing mode 0 count up
#200;
R = 1;
sel = 2'b01;
#100;
R = 0;
#1000;
P = 1;
#5;
P = 0;
end

always
#5 clk = ~clk;

endmodule
