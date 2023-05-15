`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 19:53:55
// Design Name: 
// Module Name: Access
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


module Access(
    input clk,
    input wire T2,
    input wire [7:0] X,
    input wire [15:0] IR,
    input wire [15:0] Addr,
    input wire [7:0] ALUOUT,
    output reg [7:0] Rtemp
    );
    reg [4:0] operator;


    reg RW;      //0->R,1->W
    reg en;      //en =1 代表可以
    reg MemIO;//这次是访问IO还是Mem,0->mem,1->IO
    reg [15:0] data_write;
    reg [15:0] addr;
    wire [15:0] data_read;

    CPU_export cpu_export(
    .clk(clk),
    .RW(RW),
    .en(en),
    .MemIO(MemIO),
    .data_write(data_write),
    .addr(addr),
    .data_read(data_read)
    );
    always @(posedge T2)
        begin
            operator[4:0] = IR[15:11];
            if(operator == 5'b00100)//STA
            begin
                //模拟向主存写回
                //ALUOUT->M(Addr)
                //ALUOUT->M(Addr)
                //1->W
                //1->Mem
                RW = 1;
                MemIO = 0;
                en=1;
                addr = Addr;
                data_write = ALUOUT;
            end
            if(operator == 5'b00101)//LDA
            begin
                //模拟向主存读入
                RW = 0;
                MemIO = 0;
                en=1;
                addr = Addr;
                Rtemp = data_read;
            end

            if(operator == 5'b01000)//IN
            begin
                //从IO读入
                RW = 0;
                MemIO = 1;
                en=1;
                //需要拼接
                addr = {8'b0000_0000,X};
                Rtemp = data_read;
            end
            if(operator == 5'b01001)//OUT
            begin
                //从IO写入
                RW = 1;
                MemIO = 1;
                en=1;
                //需要拼接
                addr = {8'b0000_0000,X};
                data_write = ALUOUT;
            end
        end
        //访存阶段

endmodule
