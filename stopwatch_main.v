`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 04:15:11 PM
// Design Name: 
// Module Name: stopwatch_main
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


module stopwatch_main(
    input clk,
    input P,
    input R,
    input [7:0] load,
    input [1:0] sel,
    output [3:0] an,
    output [6:0] sseg,
    output dp,
    output [1:0] cstateDb
    );
    
    wire [6:0] in0,in1,in2,in3;
    wire c_clk, d_clk;
    clk_div_disp c1(.clk(clk),.reset(R), .c_clk(c_clk),.d_clk(d_clk));
    
    stopwatch_sm c2(.c_clk(c_clk),.d_clk(d_clk), .R(R),.P(P),.sel(sel),.load(load),.dp(dp), .in0(in0), .in1(in1),.in2(in2),.in3(in3),.an(an),.sseg(sseg)
    ,.cstateDb(cstateDb)
    );
    
endmodule
