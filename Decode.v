`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 16:31:56
// Design Name: 
// Module Name: Decode
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


module Decode(
    input wire T0,
    input wire [15:0] IR,
    output reg [7:0] valA,
    output reg [7:0] valB,
    output reg [7:0] X,
    output reg [15:0] Addr
    );
    reg [4:0] operator;
    reg [7:0] R0;
    reg [7:0] R1;
    reg [7:0] R2;
    reg [7:0] R3;
    reg [7:0] R4;
    reg [7:0] R5;
    reg [7:0] R6;
    reg [7:0] R7;
    initial
        begin
            R0 = 8'b0000_0000;
            R1 = 8'b0000_0001;
            R2 = 8'b0000_0010;
            R3 = 8'b0000_0011;
            R4 = 8'b0000_0100;
            R5 = 8'b0000_0101;
            R6 = 8'b0000_0110;
            R7 = 8'b0000_0111;
        end
    always @(posedge T0)
        begin
            //选定valA
            if(IR[10:8] == 3'd0)
            begin
                valA = R0;
            end
            if(IR[10:8] == 3'd1)
            begin
                valA = R1;
            end
            if(IR[10:8] == 3'd2)
            begin
                valA = R2;
            end
            if(IR[10:8] == 3'd3)
            begin
                valA = R3;
            end
            if(IR[10:8] == 3'd4)
            begin
                valA = R4;
            end
            if(IR[10:8] == 3'd5)
            begin
                valA = R5;
            end
            if(IR[10:8] == 3'd6)
            begin
                valA = R6;
            end
            if(IR[10:8] == 3'd7)
            begin
                valA = R7;
            end
            //选定valB
            if(IR[7:5] == 3'd0)
            begin
                valB = R0;
            end
                    //选定valB
            if(IR[7:5] == 3'd1)
            begin
                valB = R1;
            end        //选定valB
            if(IR[7:5] == 3'd2)
            begin
                valB = R2;
            end        //选定valB
            if(IR[7:5] == 3'd3)
            begin
                valB = R3;
            end        //选定valB
            if(IR[7:5] == 3'd4)
            begin
                valB = R4;
            end        //选定valB
            if(IR[7:5] == 3'd5)
            begin
                valB = R5;
            end        //选定valB
            if(IR[7:5] == 3'd6)
            begin
                valB = R6;
            end        //选定valB
            if(IR[7:5] == 3'd7)
            begin
                valB = R7;
            end
            X     = IR[7:0];
            Addr[15:0] = {R7,X};//拼接
        end

endmodule
