`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 18:25:33
// Design Name: 
// Module Name: Fetch
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


module Fetch(
    input clk,
    input wire T0,
    input wire T1,
    output reg [15:0] PC_out,//往外输出的PC
    output reg [15:0] IR
    );
    reg RW;      //0->R,1->W
    reg en;      //en =1 代表可以
    reg MemIO;//这次是访问IO还是Mem,0->mem,1->IO
    reg [15:0] data_write;
    reg [15:0] PC;
    wire [15:0] IR_data;//Mem找到之后给的指令数据
    
    CPU_export cpu_export(
        .clk(clk),
        .RW(RW),
        .en(en),
        .MemIO(MemIO),
        .data_write(data_write),
        .addr(PC),
        .data_read(IR_data)
    );
    initial
    begin
        PC = 16'b0000_0000_0000_0001;//默认PC
        en =1'b0;   //默认关闭
    end

    always @(posedge T0)
    begin
        RW =1'b0;
        en =1'b1;
        MemIO =1'b0;

        PC_out <= PC;
    end

    always @(posedge T1)
    begin
        IR = IR_data;
    end
    
endmodule
