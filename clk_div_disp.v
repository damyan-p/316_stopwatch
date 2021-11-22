`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2021 11:19:11 AM
// Design Name: 
// Module Name: clk_div_disp
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


module clk_div_disp(
    input clk,
    input reset,
    output c_clk,
    output d_clk
    );
    //reg [16:0] COUNT;   //  clock speed for final (1ms) verification
    //reg [26:0] COUNT;     //  clock speed for realtime (1s) verification
    reg [1:0] COUNT;  //  clock speed for simulation
    reg [1:0] D_COUNT;
    
    //assign cnt_clk = (COUNT == 17'b11000011010100000); //  clock speed for final (1ms) verification
    //assign cnt_clk = (COUNT == 27'b101111101011110000100000000); //  clock speed for realtime (1s) verification
    assign d_clk = (COUNT[1]); //  clock speed for simulation
    assign c_clk = (D_COUNT[1]);    
    
    //assign an_clk = (COUNT == 17'b11000011010100000); //  clock speed for final (1ms) verification TODO 4x as fast
    //assign an_clk = (COUNT == 27'b101111101011110000100000000); //  clock speed for realtime (1s) verification TODO 4x as fast
    //assign an_clk = clk; //  clock speed for simulation    
    
    always @(posedge clk)
    begin
    if (reset)
        COUNT = 0;
    else        //TODO
        COUNT = COUNT + 1;
    end

    always @(posedge d_clk or posedge reset)
    begin
    if (reset)
        D_COUNT = 0;
    else
        D_COUNT = D_COUNT + 1;
    end
    

endmodule
