`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 19:13:50
// Design Name: 
// Module Name: CPU_export_read
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
测试CPU接口模块，
输入addr 0000_0000_0000_0000
向该地址写入11111_111_111_11111


然后查看addr 0000_0000_0000_0000
发现已经成为11111_111_111_11111

成功
*/
module CPU_export_write();
    reg clk;  
    reg RW;      //0->R,1->W
    reg en;      //en =1 代表可以
    reg MemIO;//这次是访问IO还是Mem,0->mem,1->IO
    reg [15:0] data_write;
    reg [15:0] addr; 
    wire [15:0] data_read;
    always #5 clk=~clk;//每10ns一次
    initial
        begin
            //先写
            clk = 0;
            RW=1;
            en=1;
            MemIO=0;
            addr =16'b0000_0000_0000_0000;
            data_write =16'b11111_111_111_11111;

            //后通过data_read看
            #20
            RW=0;
            en=1;
            MemIO=0;
            addr =16'b0000_0000_0000_0000;
        end
    CPU_export cpu_export_readTest(
    .clk(clk),
    .RW(RW),
    .en(en),
    .MemIO(MemIO),
    .data_write(data_write),
    .addr(addr),
    .data_read(data_read)
    );
endmodule
