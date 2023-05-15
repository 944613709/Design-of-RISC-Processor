`timescale 1ns / 1ps
module CPU_tb1();
    reg clk;
    reg reset;
    always #5 clk=~clk;//每10ns一次
    initial
		begin
			clk=0; reset=1;	//reset=1,将count初始化为4'b0000，否则count一直处于未知态
			#5 reset=0;	//reset=0,计数器才能正常计数
		end
CPU cpu(
    .clk(clk),
    .reset(reset)
);
endmodule
