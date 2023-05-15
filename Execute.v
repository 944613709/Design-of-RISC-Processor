`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 16:09:38
// Design Name: 
// Module Name: Execute
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


module Execute(
    input T1,
    input wire [7:0] valA,
    input wire [7:0] valB,
    input wire [7:0] X,
    input wire [15:0] Addr,
    input wire [15:0] IR,
    output reg [7:0] ALUOUT
    );
    reg [4:0] operator;
    always @(posedge T1)
    begin
        operator[4:0] = IR[15:11];
        if(operator == 5'b00000)//ADD
        begin
            ALUOUT = valA + valB;
        end
        if(operator == 5'b00001)//SUB
        begin
            ALUOUT = valA - valB;
        end
        if(operator == 5'b00010)// MOV
        begin
            ALUOUT = valB;
        end
        if(operator == 5'b00011)//MVI
        begin
            ALUOUT = X;
        end
        if(operator == 5'b00100)//STA
        begin
            ALUOUT = valA;
        end
        if(operator == 5'b00101)//LDA
        begin
            
        end
        if(operator == 5'b00110)//JZ
        begin
            ALUOUT = valA;
        end

        if(operator == 5'b00111)//JMP
        begin
            
        end

        if(operator == 5'b01000)//IN
        begin

        end
        if(operator == 5'b01001)//OUT
        begin
            ALUOUT = valA;
        end
    end
    
endmodule
