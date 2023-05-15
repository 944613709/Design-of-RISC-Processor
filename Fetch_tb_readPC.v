`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 19:08:28
// Design Name: 
// Module Name: Fetch_tb_add
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

/**
测试取指模块
PC为默认16'b0000_0000_0000_0000
取出IR指令00000_000_001_00000
成功
*/
module Fetch_tb_readPC();
    reg clk;
    reg T0;
    reg T1;
    wire [15:0] PC_out;//往外输出的PC
    wire [15:0] IR;
    always #5 clk=~clk;//每10ns一次
    initial
    begin
        clk=0;
        T0=0;
        T1=0;
        #20 T0=~T0;

        #20 T1=~T1;
    end
    Fetch fetch_test_defalut(
        .clk(clk),
        .T0(T0),
        .T1(T1),
        .PC_out(PC_out),
        .IR(IR)
    );
endmodule
