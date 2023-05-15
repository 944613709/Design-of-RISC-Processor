`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 16:37:23
// Design Name: 
// Module Name: Decode_tb_add
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
测试译码模块，输入IR 00000_000_001_00000，
译码得到输出valA，valB，X，Addr
成功
*/
module Decode_tb_add();
    reg T0;
    reg [15:0] IR;
    wire [7:0] valA;
    wire [7:0] valB;
    wire [7:0] X;
    wire [15:0] Addr;
    always #5 T0=~T0;//每10ns一次
        initial
        begin
            T0 = 1'b0;
            IR = 16'b00000_000_001_00000;//测试ADD R0+R1
        end
    Decode testADD(T0,IR,valA,valB,X,Addr);
endmodule
