`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EE 316 Digital Logic Design
// Engineer: Damyan Pavlovic
// 
// Create Date: 10/22/2021 11:19:11 AM
// Design Name: stopwatch_main
// Module Name: clk_div_disp
// Project Name: 316_stopwatch
// Target Devices: Basys3 
// Tool Versions: 
// Description: clock division module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.02 - added realtime simulation speed
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div_disp(
    input clk,
    input reset,
    output c_clk,
    output d_clk
    );
    //reg [16:0] COUNT;                 //  uncomment for clock speed for final (1ms) verification
    reg [26:0] COUNT;             //  uncomment for 1s realtime counter speed
    //reg [1:0] COUNT;                //  uncomment for simulation clock speed
    reg [1:0] D_COUNT;
    

    //assign d_clk = (COUNT[1]);                  //  simulation clock speed
    //assign d_clk = (COUNT == 17'd100000);  //  uncomment for 1ms realtime counter speed
    assign d_clk = (COUNT == 27'd100000000);  //  uncomment for 1s realtime counter speed
    
    assign c_clk = (D_COUNT[1]);    
    
    always @(posedge clk)
    begin
    if (reset)
        COUNT = 0;
        
    /*  
    //  uncomment for 1ms realtime counter speed, comment for simulation counter speed
    else if(COUNT == 17'd100000)
        COUNT = 0;
    */
    
    //  uncomment for 1s realtime counter speed, comment for simulation counter speed
    else if(COUNT == 27'd100000000)
        COUNT = 0;
    
   
    else
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
