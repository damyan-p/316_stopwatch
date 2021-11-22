`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE 316 Digital Logic Design
// Engineer: Damyan Pavlovic
// 
// Create Date: 10/22/2021 11:19:11 AM
// Design Name: stopwatch_main
// Module Name: tb_stopwatch
// Project Name: 316_stopwatch
// Target Devices: Basys3, XC7A35TCPG236-1
// Tool Versions: 
// Description: clock division module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02 - added 
// Additional Comments: added mode 2, 3 testing
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
P = 1;  //  testing mode 1 count up from 99.00
#5;
P = 0;  //  testing mode 0 count up
#200;
R = 1;
sel = 2'b10;
#100;
R = 0;
#1000;
P = 1;
#5;
P = 0;  //  testing mode 2 count down from 99.99
#200;
R = 1;
sel = 2'b11;
load = 8'h01;
#100;
R = 0;
#1000;
P = 1;
#5;
P = 0;  //  testing mode 3 count down from 01.00
end

always
#5 clk = ~clk;

endmodule
