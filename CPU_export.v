`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 18:26:04
// Design Name: 
// Module Name: CPU_export
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


module CPU_export(
    input clk,  
    input wire RW,      //0->R,1->W
    input wire en,      //en =1 代表可以
    input wire MemIO,//这次是访问IO还是Mem,0->mem,1->IO
    input wire [15:0] data_write,
    input wire [15:0] addr, 
    output reg [15:0] data_read
    );
    //模拟存储器
    reg [15:0] addr0;
    reg [15:0] data0;
    reg [15:0] addr1;
    reg [15:0] data1;
    reg [15:0] addr2;
    reg [15:0] data2;
    reg [15:0] addr3;
    reg [15:0] data3;
    reg [15:0] addr4;
    reg [15:0] data4;
    reg [15:0] addr5;
    reg [15:0] data5;
    reg [15:0] addr6;
    reg [15:0] data6;
    reg [15:0] addr7;
    reg [15:0] data7;
    reg [15:0] addr8;
    reg [15:0] data8;
    reg [15:0] addr9;
    reg [15:0] data9;
    reg [15:0] addrR7X;
    reg [15:0] dataR7X;
    //模拟IO接口
    reg [15:0] portAddr;
    reg [15:0] portData;
    initial
        begin
            //主存中存的PC地址和指令
            addr0 = 16'b0000_0000_0000_0000;//地址
            data0 = 16'b00000_000_001_00000;//ADD R0+R1                       //PC指令数据

            addr1 = 16'b0000_0000_0000_0001;//地址
            data1 = 16'b00001_011_001_00000;//SUB R3-R1                       //PC指令数据

            addr2 = 16'b0000_0000_0000_0010;//地址
            data2 = 16'b00010_000_001_00000;//MOV (Rj)R1 -> R0(Ri)                       //PC指令数据

            addr3 = 16'b0000_0000_0000_0011;//地址
            data3 = 16'b00011_000_111_11111;//MVI X(1111_1111) -> Ri(R0)                       //PC指令数据

            addr4 = 16'b0000_0000_0000_0100;//地址
            data4 = 16'b00100_000_0000_1000;//STA R0 -> [R7//X] (X=0000_1000)                       //PC指令数据

            addr5 = 16'b0000_0000_0000_0101;//地址
            data5 = 16'b00101_000_0000_1000;//LDA [R7//X] -> Ri(R0) (X=0000_1000)                      //PC指令数据

            addr6 = 16'b0000_0000_0000_0110;//地址      (R0确实为0)
            data6 = 16'b00110_000_0000_1000;//JZ if(Ri Ro == 0) then [R7//X]->PC             (X=0000_1000)           //PC指令数据

            addr7 = 16'b0000_0000_0000_0111;//地址
            data7 = 16'b00111_000_0000_1000;//JMP [R7//X] -> PC  (X=0000_1000)                       //PC指令数据

            addr8 = 16'b0000_0000_0000_1000;//地址
            data8 = 16'b01000_000_1111_1111;//IN [PORT] -> Ri(R0) (PORT=1111_1111)后续在访存模块会补充为0000_0000_1111_1111                       //PC指令数据

            addr9 = 16'b0000_0000_0000_1001;//地址
            data9 = 16'b01001_000_1111_1111;//OUT Ri(R0) ->[PORT] (PORT=1111_1111)后续在访存模块会补充为0000_0000_1111_1111                       //PC指令数据

            //[R7//X]会涉及到的地址
            addrR7X = 16'b0000_0111_0000_1000;
            dataR7X = 16'b1111_1111_1111_1111;
            //IO接口
            portAddr = 16'b0000_0000_1111_1111; //设定这里为port地址
            portData = 16'b1111_1111_1111_1111; //设定为port数据
        end
    always@(posedge clk)
        begin
            if(en == 1 && MemIO == 0)
            begin
                //从主存中读R
                if(RW == 0)
                begin
                    if(addr == addr0)
                        data_read = data0;
                    else if(addr == addr1)
                        data_read = data1;
                    else if(addr == addr2)
                        data_read = data2;
                    else if(addr == addr3)
                        data_read = data3;
                    else if(addr == addr4)
                        data_read = data4;
                    else if(addr == addr5)
                        data_read = data5;
                    else if(addr == addr6)
                        data_read = data6;
                    else if(addr == addr7)
                        data_read = data7;
                    else if(addr == addr8)
                        data_read = data8;
                    else if(addr == addr9)
                        data_read = data9;
                    else if(addr == addrR7X)
                        data_read = dataR7X;
                end

                //从主存中写W
                if(RW == 1)
                begin
                    if(addr == addr1)
                        data1 = data_write;
                    else if(addr == addr2)
                        data2 = data_write;
                    else if(addr == addr3)
                        data3 = data_write;
                    else if(addr == addr4)
                        data4 = data_write;
                    else if(addr == addr5)
                        data5 = data_write;
                    else if(addr == addr6)
                        data6 = data_write;
                    else if(addr == addr7)
                        data7 = data_write;
                    else if(addr == addr8)
                        data8 = data_write;
                    else if(addr == addr9)
                        data9 = data_write;
                    else if(addr == addrR7X)
                        dataR7X = data_write;
                end
            end


            if(en == 1 && MemIO == 1)
            begin
                //从IO中读R
                if(RW == 0)
                begin
                    if(addr == portAddr)
                        data_read = portData;
                end
                //从IO中写W
                if(RW == 1)
                begin
                    if(addr == addr1)
                        portData = data_write;
                end
            end
        end
endmodule
