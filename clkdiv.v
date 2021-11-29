`timescale 1ns / 1ps

module clkdiv(
    input clk, 
    input reset,
    output c_clk, // does the counting 
    output d_clk // display clk  
    );
    
            reg [18:0] COUNT; // board display 
            
            reg [19:0] TIME_COUNT; 
       
           //reg [1:0] COUNT; 
            
            assign d_clk = COUNT[18]; // real
            assign c_clk = (TIME_COUNT == 19'd1000000);// the stopwatch counter 
            
            
            //assign d_clk = COUNT[1]; // simulation 
            
            always @ (posedge clk)
                begin 
                if (reset) begin
                    COUNT <= 0; 
                    TIME_COUNT <= 0; 
                end
                if( TIME_COUNT == 1000000 )
                    TIME_COUNT = 0; 
                else begin
                    COUNT <= COUNT + 1;
                    TIME_COUNT <= TIME_COUNT + 1;  
                end
            
            end 
    
    
   
    
    
endmodule
