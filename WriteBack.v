`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 19:54:07
// Design Name: 
// Module Name: WriteBack
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


module WriteBack(
    input wire T3,
    input wire [7:0] Rtemp,
    input wire [7:0] ALUOUT,
    input wire [15:0] Addr,
    input wire [15:0] IR,
    output reg [15:0] PC_jump_data,
    output reg  PC_jump_en,
    output reg [7:0] R_data,
    output reg [15:0] R_select,
    output reg  R_en
    );
    reg [4:0] operator;
    always @(posedge T3)
    begin
        operator[4:0] = IR[15:11];
        //写回阶段
        //执行ALUOUT -> Reg(Ad1(IR))
        if(operator == 5'b00000 
        || operator == 5'b00001
        || operator == 5'b00010
        || operator == 5'b00011)//ADD SUB MOV MVI
        begin
            R_select = IR[10:8];
            R_data = ALUOUT;
            R_en = 1;
        end

        //Rtemp -> Reg(Ad1(IR))
        if(operator == 5'b00101 || operator == 5'b01000) //LDA IN
        begin
            R_select =  IR[10:8];
            R_data  = Rtemp;
            R_en =1;
        end

        //If ALUOUT==0
        // Then
        // Addr->PC
        if(operator == 5'b00110) //JZ
        begin
            if(ALUOUT == 1'd0)
            begin
                PC_jump_data = Addr;
                PC_jump_en = 1;
            end
        end

        //Addr->PC
        if(operator == 5'b00111)//JMP
        begin
            PC_jump_data = Addr;
            PC_jump_en = 1;
        end


        if(operator == 5'b01001)//OUT
        begin

        end
    end
endmodule
