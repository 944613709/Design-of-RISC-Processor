`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 16:14:40
// Design Name: 
// Module Name: Execute_tb_add
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
测试执行模块，
输入IR 00000_000_001_00000，valA，valB，X，Addr
译码得到输出ALUOUT
成功
*/
module Execute_tb_add();
    reg T1;
    reg [7:0] valA;
    reg [7:0] valB;
    reg [7:0] X;
    reg [15:0] Addr;
    reg [15:0] IR;
    wire [7:0] ALUOUT;
    always #5 T1=~T1;//每10ns一次
    initial
        begin
            T1 = 1'b0;
            valA = 8'b0000_0001;
            valB = 8'b0000_1110;
            X    = 8'b0000_1111;
            Addr = 16'b0000_0000_0000_0001;
            IR = 16'b00000_000_001_00000;//测试ADD R0+R1（valA+valB）
        end
    Execute testADD(T1,valA,valB,X,Addr,IR,ALUOUT);
endmodule
