`timescale 1ns/1ns		//时间精度为1ns
/**
测试Clock模块
让其产生周期T0~T3
成功
*/

module Clock_tb();
	reg clk,reset;		//initial语句块中左边必须是reg型
	wire T0,T1,T2,T3;
	wire [1:0] count;
//	defparam u.N=4;	//将默认的模6改为模4
	always #5 clk=~clk;	//每5ns翻转一次，10ns为一周期
	initial
		begin
			clk=0; reset=1;	//reset=1,将count初始化为4'b0000，否则count一直处于未知态
			#5 reset=0;	//reset=0,计数器才能正常计数
		end
		counter u(.clk(clk),.reset(reset),.count(count),.T0(T0),.T1(T1),.T2(T2),.T3(T3));
endmodule
