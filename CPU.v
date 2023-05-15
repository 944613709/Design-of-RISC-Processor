`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/07 16:51:42
// Design Name: 
// Module Name: CPU
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
module CPU(
input wire clk,
input wire reset
);

wire [1:0] count;
wire T0;
wire T1;
wire T2;
wire T3;
wire [15:0] PC_out;//往外输出的PC
wire [15:0] IR;
wire [7:0] valA;
wire [7:0] valB;
wire [7:0] X;
wire [15:0] Addr;
wire [7:0] ALUOUT;
wire [7:0] Rtemp;


wire [15:0] PC_jump_data;
wire  PC_jump_en;
wire [7:0] R_data;
wire [15:0] R_select;
wire  R_en;

Clock clock(
    .clk(clk),
    .reset(reset),
    .count(count),
    .T0(T0),
    .T1(T1),
    .T2(T2),
    .T3(T3)
);

Fetch fetch(
    .clk(clk),
    .T0(T0),
    .T1(T1),
    .PC_out(PC_out),
    .IR(IR)
);
Decode decode(
    .T0(T0),
    .IR(IR),
    .valA(valA),
    .valB(valB),
    .X(X),
    .Addr(Addr)
);
Execute execute(
    .T1(T1),
    .valA(valA),
    .valB(valB),
    .X(X),
    .Addr(Addr),
    .IR(IR),
    .ALUOUT(ALUOUT)
);

Access access(
    .clk(clk),
    .T2(T2),
    .X(X),
    .IR(IR),
    .Addr(Addr),
    .ALUOUT(ALUOUT),
    .Rtemp(Rtemp)
);
WriteBack writeBack(
    .T3(T3),
    .Rtemp(Rtemp),
    .ALUOUT(ALUOUT),
    .Addr(Addr),
    .IR(IR),
    .PC_jump_data(PC_jump_data),
    .PC_jump_en(PC_jump_en),
    .R_data(R_data),
    .R_select(R_select),
    .R_en(R_en)
);

endmodule