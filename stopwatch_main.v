`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE 316 Digital
// Engineer: Damyan Pavlovic
// 
// Create Date: 10/22/2021 11:19:11 AM
// Design Name: stopwatch_main
// Module Name: stopwatch_main
// Project Name: 316_stopwatch
// Target Devices: Basys3, XC7A35TCPG236-1
// Tool Versions: 
// Description: main method
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02 - removed sim debug
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stopwatch_main(
    input clk,
    input P,
    input R,
    input [7:0] load,
    input [1:0] sel,
    output [3:0] an,
    output [6:0] sseg,
    output dp
    );
    
    wire [6:0] in0,in1,in2,in3;
    wire c_clk, d_clk;
    clk_div_disp c1(.clk(clk),.reset(R), .c_clk(c_clk),.d_clk(d_clk));
    
    stopwatch_sm c2(.c_clk(c_clk),.d_clk(d_clk), .R(R),.P(P),.sel(sel),.load(load),.dp(dp), .in0(in0), .in1(in1),.in2(in2),.in3(in3),.an(an),.sseg(sseg)
    );
    
endmodule
