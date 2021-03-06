`timescale 1ns / 1ps


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
/*
//                  uncomment to test mode 0 countup
P=0;
clk = 0;
load = 8'h91;
sel = 2'b00;
R = 0;
#10;
R = 1;
#200;
R = 0;
#100;
P = 1;
#5;
P = 0;
*/


//                  uncomment to test mode 1 countup
P=0;
clk = 0;
load = 8'h91;
sel = 2'b01;
R = 0;
#10;
R = 1;
#200;
R = 0;
#100;
P = 1;
#5;
P = 0;


/*
//                  uncomment to test mode 2 countdown
P=0;
clk = 0;
load = 8'h01;
sel = 2'b10;
R = 0;
#10;
R = 1;
#200;
R = 0;
#100;
P = 1;
#5;
P = 0;
*/

/*
//                  uncomment to test mode 3 countdown
P=0;
clk = 0;
load = 8'h01;
sel = 2'b11;
R = 0;
#10;
R = 1;
#200;
R = 0;
#100;
P = 1;
#5;
P = 0;
*/
end

always
#5 clk = ~clk;

endmodule
