`timescale 1ns / 1ps
 

module clk_div_disp(
    input clk,
    input reset,
    output c_clk,
    output d_clk
    );
    //reg [18:0] COUNT;                 //  Simulation 
    //reg [1:0] D_COUNT;                // Simulation 
    
    
    reg [28:0] COUNT;             // real time  
    reg [1:0] D_COUNT;          // real time 
    

    //assign d_clk = (COUNT[1]);                  //  simulation clock speed
    //assign d_clk = (COUNT == 19'd400000);  //  uncomment for 1ms realtime counter speed
    
    
    assign d_clk = (COUNT == 29'd400000000);    //real time 
    assign c_clk = (D_COUNT[1]);                //real time 
    
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
