`timescale 1ns / 1ps


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
    output reg [6:0] sseg
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
    
    //  converting C counter output to seven-segment displays in[3:]
    //  in[3:0] put into an[3:0] during display fsm @100
    hexto7segment c3(.x(C[15:12]),.r(in3));
    hexto7segment c4(.x(C[11:8]),.r(in2));
    hexto7segment c5(.x(C[7:4]),.r(in1));
    hexto7segment c6(.x(C[3:0]),.r(in0));
    
    //  initializing state changes for state (display fsm)
    always @ (*) begin
        case(state)
            default: begin
                    next_state = 2'b00;
                    state = 2'b00;
                    end
            2'b00: next_state = 2'b11;
            2'b01: next_state = 2'b00;
            2'b10: next_state = 2'b01;
            2'b11: next_state = 2'b10;
        endcase
    //  initializing state changes for state (controller fsm)
        case(cstate)
            default: begin
                    cstate = 2'b00;
                    next_cstate = 2'b00;
                    end
            2'b00: begin
                    if(R)
                        next_cstate = 2'b00;
                    else
                        next_cstate = 2'b10;
                    end
            2'b01: begin
                    if(R)
                        next_cstate = 2'b00;
                    else if(P)
                        next_cstate = 2'b10;
                    else
                    next_cstate = 2'b01;
                end
            2'b10: begin
                    if(R)
                        next_cstate = 2'b00;
                    else if(P)
                        next_cstate = 2'b01;
                    else
                        next_cstate = 2'b10;
                end
            2'b11: begin
                    if(R)
                        next_cstate = 2'b00;
                    else
                        next_cstate = 2'b11;
                end
        endcase
    end
    
    //  defining fsm; state defines output to each display an[3:0]
    always @ (*) begin
        case(state)
            2'b00: begin
                    sseg = in0;
                    dp_reg = 1; // maybe set as 0 
                    an = 4'b1110;
                    end
            2'b01: begin
                    sseg = in1;
                    dp_reg = 1; // maybe set as 0
                    an = 4'b1101;
                    end
            2'b10: begin
                    sseg = in2;
                    dp_reg = 0; // maybe set as 1
                    an = 4'b1011;
                    end
            2'b11: begin
                    sseg = in3;
                    dp_reg = 1; // maybbe set as 0 
                    an = 4'b0111;
                    end
        endcase
        //  defining fsm; state defines counter clear/count
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
        //  counter implementation
        //  based on mode sel[1:0]
        //  mode 0, 1: upcounter from 0, 16'h[load[7:4],load[3:0],0,0]
        //  mode 2, 3: downcounter from 16'h9999, 16'h[load[7:4],load[3:0],0,0]
        
    always @ (posedge c_clk or posedge C_clr) begin
        if(C_clr) begin
        //  mode 0 clear
            if(~(sel[1]) && ~(sel[0])) begin
                C <= 0;
            end
        //  mode 1 clear
            if(~(sel[1]) && (sel[0])) begin
                C[7:0] <= 0;
                C[15:12] <= load[7:4];
                C[11:8] <= load[3:0];
            end
        //  mode 2 clear
            if((sel[1]) && ~(sel[0])) begin
                C[3:0] <= 4'h9;
                C[7:4] <= 4'h9;
                C[11:8] <= 4'h9;
                C[15:12] <= 4'h9;
            end
        //  mode 3 clear
            if((sel[1]) && (sel[0])) begin
                C[7:0] <= 0;
                C[15:12] <= load[7:4];
                C[11:8] <= load[3:0];
            end
        end
        else if(C_cnt) begin
        //  mode 0 upcounter
            if(~(sel[1]) && ~(sel[0])) begin
                if(C != 16'h9999)
                    C[3:0] <= C[3:0] + 1;
                if(C[3:0] == 4'h9 && (C != 16'h9999)) begin
                    C[3:0] <= 0;
                    C[7:4] <= C[7:4] + 1;
                end
                if(C[3:0] == 4'h9 && C[7:4] == 4'h9 && (C != 16'h9999)) begin
                    C[7:4] <= 0;
                    C[11:8] <= C[11:8] + 1;
                end
                if(C[3:0] == 4'h9 && C[7:4] == 4'h9 && C[11:8] == 4'h9 && (C != 16'h9999)) begin
                    C[11:8] <= 0;
                    C[15:12] <= C[15:12] + 1;
                end
            end
        //  mode 1 upcounter
            else if(~(sel[1]) && (sel[0])) begin
                if(C != 16'h9999)
                   C[3:0] <= C[3:0] + 1;
                if(C[3:0] == 4'h9 && (C != 16'h9999)) begin
                    C[3:0] <= 0;
                    C[7:4] <= C[7:4] + 1;
                end
                if(C[3:0] == 4'h9 && C[7:4] == 4'h9 && (C != 16'h9999)) begin
                    C[3:0] <= 0;
                    C[7:4] <= 0;
                    C[11:8] <= C[11:8] + 1;
                end
                if(C[3:0] == 4'h9 && C[7:4] == 4'h9 && C[11:8] == 4'h9 && (C != 16'h9999)) begin
                    C[3:0] <= 0;
                    C[7:4] <= 0;
                    C[11:8] <= 0;
                    C[15:12] <= C[15:12] + 1;
                end
            end
        //  mode 2 downcounter
            else if((sel[1]) && ~(sel[0])) begin
                if(C[11:8] == 0 && C[7:4] == 0 && C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[15:12] <= C[15:12] - 1;
                    C[11:8] <= 4'h9;
                    C[7:4] <= 4'h9;
                    C[3:0] <= 4'h9;
                end
                else if(C[7:4] == 0 && C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[11:8] <= C[11:8] - 1;
                    C[7:4] <= 4'h9;
                    C[3:0] <= 4'h9;
                end
                else if(C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[7:4] <= C[7:4] - 1;
                    C[3:0] <= 4'h9;
                end
                else if(C != 16'h0000)
                C[3:0] <= C[3:0] - 4'h1;
            end
        //  mode 3 downcounter
            else if((sel[1]) && (sel[0])) begin
                if(C[11:8] == 0 && C[7:4] == 0 && C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[15:12] <= C[15:12] - 1;
                    C[11:8] <= 4'h9;
                    C[7:4] <= 4'h9;
                    C[3:0] <= 4'h9;
                end
                else if(C[7:4] == 0 && C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[11:8] <= C[11:8] - 1;
                    C[7:4] <= 4'h9;
                    C[3:0] <= 4'h9;
                end
                else if(C[3:0] == 4'h0 && (C != 16'h0000)) begin
                    C[7:4] <= C[7:4] - 1;
                    C[3:0] <= 4'h9;
                end
                else if(C != 16'h0000)
                C[3:0] <= C[3:0] - 4'h1;
            end
        end
    end
    
        //  moves fsms on posedge of relevant clock
    always @ (posedge d_clk) begin
        state <= next_state;
        cstate <= next_cstate;
        end    
    
endmodule
