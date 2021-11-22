`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 04:28:35 PM
// Design Name: 
// Module Name: stopwatch_sm
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


module stopwatch_sm(
    input c_clk,
    input d_clk,
    input R,
    input P,
    input [1:0] sel,
    input [7:0] load,
    output dp,
    output [6:0] in0,
    output [6:0] in1,
    output [6:0] in2,
    output [6:0] in3,
    output reg [3:0] an,
    output reg [6:0] sseg,
    output [1:0] cstateDb
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    reg [1:0] cstate;
    reg [1:0] next_cstate;
    reg [15:0] C;
    reg dp_reg;
    reg C_clr;
    reg C_cnt;

    assign dp = dp_reg;
    assign cstateDb[1] = C_clr;
    assign cstateDb[0] = C_cnt;
    
    hexto7segment c3(.x(C[15:12]),.r(in3));
    hexto7segment c4(.x(C[11:8]),.r(in2));
    hexto7segment c5(.x(C[7:4]),.r(in1));
    hexto7segment c6(.x(C[3:0]),.r(in0));
    
    always @ (*) begin
        case(state)
            default: next_state = 2'b00;
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b11;
            2'b11: next_state = 2'b00;
        endcase
        case(cstate)
            default: next_cstate = 2'b00;
            2'b00: begin
                    if(R)
                        next_cstate = 2'b00;
                    else if(P)
                        next_cstate = 2'b01;
                    end
            2'b01: begin
                    if(R)
                        next_cstate = 2'b00;
                    else if(P)
                        next_cstate = 2'b10;
                    else if(C == 16'h9999) // TODO
                        next_cstate = 2'b11;
                end
            2'b10: begin
                    if(R)
                        next_cstate = 2'b00;
                    else if(P)
                        next_cstate = 2'b01;
                end
            2'b11: begin
                    if(R)
                        next_cstate = 2'b00;
                    else
                        next_cstate = 2'b11;
                end
        endcase
    end
    
    always @ (*) begin
        case(state)
            2'b00: begin
                    sseg = in0;
                    dp_reg = 1;
                    an = 4'b0001;
                    end
            2'b01: begin
                    sseg = in1;
                    dp_reg = 1;
                    an = 4'b0010;
                    end
            2'b10: begin
                    sseg = in2;
                    dp_reg = 0;
                    an = 4'b0100;
                    end
            2'b11: begin
                    sseg = in3;
                    dp_reg = 1;
                    an = 4'b1000;
                    end
        endcase
        case(cstate)
            2'b00: begin
                    C_clr = 1;
                    C_cnt = 0;
                    end
            2'b01: begin
                    C_clr = 0;
                    C_cnt = 1;
                    end
            2'b10: begin
                    C_clr = 0;
                    C_cnt = 0;
                    end
            2'b11: begin
                    C_clr = 0;
                    C_cnt = 0;
                    end
        endcase
    end
    
    always @ (posedge c_clk or posedge C_clr) begin
        if(C_clr) begin
            if(~(sel[1]) && ~(sel[0]))
                C <= 0;
            if(~(sel[1]) && (sel[0])) begin
                C[7:0] <= 0;
                C[15:12] <= load[7:4];
                C[11:8] <= load[3:0];
                end
            if((sel[1]) && ~(sel[0])) begin
                C[3:0] <= 4'h9;
                C[7:4] <= 4'h9;
                C[11:8] <= 4'h9;
                C[15:12] <= 4'h9;
                end
            if((sel[1]) && (sel[0])) begin
                C[7:0] <= 0;
                C[15:12] <= load[7:4];
                C[11:8] <= load[3:0];
                end
            end
        else if(C_cnt) begin
            if(~(sel[1]) && ~(sel[0]))
                C[3:0] <= C[3:0] + 1;
                if(C[3:0] == 4'h9) begin
                    C[3:0] <= 0;
                    C[7:4] <= C[7:4] + 1;
                    if(C[7:4] == 4'h9) begin
                        C[7:4] <= 0;
                        C[11:8] <= C[11:8] + 1;
                        if(C[11:8] == 4'h9) begin
                            C[11:8] <= 0;
                            C[15:12] <= C[15:12] + 1;
                        end
                    end
                end
            //end
                if(~(sel[1]) && (sel[0])) begin
                    C[3:0] <= C[3:0] + 1;
                    if(C[3:0] == 4'h9) begin
                        C[3:0] <= 0;
                        C[7:4] <= C[7:4] + 1;
                        if(C[7:4] == 4'h9) begin
                            C[7:4] <= 0;
                            C[11:8] <= C[11:8] + 1;
                            if(C[11:8] == 4'h9) begin
                                C[11:8] <= 0;
                                C[15:12] <= C[15:12] + 1;
                            end
                        end
                    end
                end
                if((sel[1]) && ~(sel[0])) begin
                    if(C[3:0] == 1'h0) begin
                        if(C[7:4] == 1'h0) begin
                            if(C[11:8] == 1'h0) begin
                                C[15:12] <= C[15:12] - 1'h1;
                                C[11:8] <= 4'hA;
                            end
                            C[11:8] <= C[11:8] - 1'h1;
                            C[7:4] <= 4'hA;
                        end
                        C[7:4] <= C[7:4] - 1'h1;
                        C[3:0] <= 4'hA;
                    end
                    C[3:0] <= C[3:0] - 4'hA;
                end
                
              if((sel[1]) && (sel[0])) begin
                    if(C[3:0] == 1'h0) begin
                        if(C[7:4] == 1'h0) begin
                            if(C[11:8] == 1'h0) begin
                               C[15:12] <= C[15:12] - 1'h1;
                                C[11:8] <= 4'hA;
                            end
                            C[11:8] <= C[11:8] - 1'h1;
                            C[7:4] <= 4'hA;
                        end
                        C[7:4] <= C[7:4] - 1'h1;
                       C[3:0] <= 4'hA;
                    end
                    C[3:0] <= C[3:0] - 4'hA;
                end
            end
        end //add
    
    always @ (posedge d_clk or posedge R) begin
        state <= next_state;
        cstate <= next_cstate;
        end    
    
endmodule
