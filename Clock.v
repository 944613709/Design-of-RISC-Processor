//N进制计数器
module Clock(
    input wire clk,
    input wire reset,
    output reg [1:0] count,
    output reg T0,
    output reg T1,
    output reg T2,
    output reg T3);
	parameter N=4;			//定义进制N的值
    initial
    begin
        count = 2'b00;
    end
	always@(posedge clk)		//当有时钟上升沿来到，执行下列语句
    begin
        if(count == 2'b00)
        begin
            T0  <= 1'b1;
            T1  <= 1'b0;
            T2  <= 1'b0;
            T3  <= 1'b0;
        end
        if(count == 2'b01)
        begin
            T0  <= 1'b0;
            T1  <= 1'b1;
            T2  <= 1'b0;
            T3  <= 1'b0;
        end
        if(count == 2'b10)
        begin
            T0  <= 1'b0;
            T1  <= 1'b0;
            T2  <= 1'b1;
            T3  <= 1'b0;
        end
        if(count == 2'b11)
        begin
            T0  <= 1'b0;
            T1  <= 1'b0;
            T2  <= 1'b0;
            T3  <= 1'b1;
        end
		if(reset)		//清零信号=1，则清零
			count<=2'b00;	//有效计数器清零
		else
			if(count == 2'b11)	//是否计导第N个数(0-N)
				count<=2'b00;	//清零
			else			//否则加1
				count<=count+1;
    end
endmodule
