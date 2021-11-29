`timescale 1ns / 1ps

module clkdiv(
    input clk, 
    input reset,
    output c_clk, // does the counting 
    output d_clk // display clk  
    );
    
            reg [23:0] COUNT; // board display 
            
            reg [16:0] TIME_COUNT; 
       
           //reg [1:0] COUNT; 
            
            assign d_clk = COUNT[23]; // real
            assign c_clk = TIME_COUNT[16];// the stopwatch counter 
            
            
            //assign d_clk = COUNT[1]; // simulation 
            
            always @ (posedge clk)
                begin 
                if (reset) begin
                    COUNT <= 0; 
                    TIME_COUNT <= 0; 
                end 
            
            
//                if( TIME_COUNT >= 100000 ) begin
//                    TIME_COUNT = 0; 
                    
//                end 
            
            
                else begin
                    COUNT <= COUNT + 1;
                    TIME_COUNT <= TIME_COUNT + 1;  
                end
            
            end 
    
    
   
    
    
endmodule
