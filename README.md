# RISC_CPU_HIT
 RISC处理器设计

# 要求

根据计算机组成原理课程所学的知识，设计一个给定指令系统的处理器，深刻理解处理器结构和计算机系统的整体工作原理。

#### 1. 处理器功能及指令系统定义

本实验的任务是设计一个简单的RISC处理器，该处理器是在给定的指令集下构建的，支持十条指令。假定主存可以在一个时钟周期内完成一次存取操作，而且可以和CPU同步工作。系统使用一个主存单元：指令读取和数据访问都使用同一组存储器。

处理器的指令字长为16位，包含8个8位通用寄存器R0~R7，1个16位的指令寄存器IR和1个16位的程序计数器PC。取指令时，可以直接从主存中提取16位的指令信息，而进行数据访问时，与主存进行8位的数据交换。处理器的地址总线宽度是16位，数据总线宽度也是16位，无论是取指还是数据访问，都使用同一组数据总线，只是数据信息的宽度不同。

处理器所支持的指令包括LDA，STA，MOV，MVI，ADD，SUB，JZ，JMP，IN，OUT。其中仅有LDA和STA是访存指令，所有的存储器访问都通过这两条指令完成；ADD和SUB是运算指令，MOV和MVI是传数指令，他们都在处理器内部完成；JZ是跳转指令，根据寄存器的内容进行绝对跳转；JMP是无条件转移指令；IN和OUT是输入输出指令，所有I/O端口与CPU之间的通信都由IN和OUT指令完成。

**1)** **非访存指令**

（1）加法指令ADD Ri, Rj

该指令在执行阶段需完成两个寄存器内容相加，结果送回寄存器的操作，具体为：Ri + Rj → Ri

（2）减法指令SUB Ri, Rj

该指令在执行阶段需完成两个寄存器内容相减，结果送回寄存器的操作，具体为：Ri -Rj → Ri

（3）寄存器传送指令MOV Ri, Rj

该指令在执行阶段只完成数据信息从寄存器Rj向寄存器Ri传送的操作，具体为： Rj → Ri

（4）立即数传送指令MVI Ri, X

该指令在执行阶段只完成指令中的8位立即数X向寄存器Ri传送的操作，具体为： X → Ri

**2)****访存指令**

采用扩充寻址的方式支持访存。

**扩充寻址的定义：**

（1）存数指令STA  Ri, X

该指令在执行阶段需将寄存器Ri的内容存于主存单元中，对应的地址由8位形式地址X经扩充寻址生成，R7充当扩充寻址寄存器，即主存实际地址记为R7//X，具体操作为：Ri → [R7//X]

（2）取数指令LDA Ri, X

该指令在执行阶段需将主存单元中的内容存于寄存器Ri，对应的地址由8位形式地址X经扩充寻址生成，R7充当扩充寻址寄存器，即主存实际地址记为R7//X，具体操作为：[R7//X] → Ri

**3****．转移类指令**

（1）条件转移（零则转）指令JZ Ri, X

该指令根据寄存器Ri的内容决定下一条指令的地址，若寄存器内容为零，则8位形式地址X经寄存器R7扩充寻址后形成有效地址R7//X，送至PC，否则程序按原顺序执行。具体操作为：if (Ri = 0) then [R7//X] → PC

（2）无条件转移指令JMP X

该指令改变下一条指令的地址，指令码中的8位形式地址X经寄存器R7扩充寻址后形成有效地址R7//X，送至PC，记为：[R7//X] → PC

**4****．****I/O****指令（选做，加分项****1****）**

（1）输入指令IN Ri, PORT

该指令完成从I/O端口到CPU的信息传送，指令码中的端口号PORT为端口地址，传送的是端口中的信息，送至Ri, 记为：[PORT] → Ri

（2）输出指令OUT Ri, PORT

该指令完成从CPU到I/O端口的信息传送，指令码中的端口号PORT为端口地址，记为：Ri → [PORT]

#### 2. 设计要求

要求根据以上给定的指令系统设计RISC处理器，处理器工作流程按取指、译码、运算、访存、写回五个阶段进行。控制器设计方法可选（组合逻辑设计

需完成的环节包括：

1）指令格式设计；

2） 微操作的定义；

3） 节拍的划分；

4） 处理器结构设计框图及功能描述；

5） 如采用组合逻辑设计，列出操作时间表，画出每个控制信号的逻辑图；

7）加分项2：用Verilog实现该CPU，并仿真验证其功能。

# 说明

![image-20230515201018110](https://farsblog.oss-cn-beijing.aliyuncs.com/PicGo/202305152010232.png)

​					程序框图

## 报告内容

一、 指令格式设计；	3
二、 微操作的定义；	4
（一） 取指阶段	4
（二） 执行阶段	4
说明：	5
三、 节拍的划分；	6
（一） 取指阶段	8
1． 取指周期T0	8
2． 取指周期T1	8
3． 取指周期T2	9
4． 取指周期T3	9
（二） 执行阶段	9
1． 译码周期T0	9
2． 运算周期T1	9
3． 访存周期T2	10
4． 写回周期T3	11
四、 处理器结构设计框图及功能描述；	12
（一） 处理器结构设计框图	12
（二） 处理器模块划分	13
（三） 各模块说明及功能描述	13
1． Clock模块	13
2． CPU内外接口管理模块	14
3． Fetch模块	15
4． Decode模块	16
5． Execute模块	17
6． Access模块	18
7． WriteBack模块	19
五、 如采用组合逻辑设计，列出操作时间表，画出每个控制信号的逻辑图；	20
（一） 操作时间表	20
（二） 每个控制信号逻辑图	22
1． FE----取指周期	22
2． EX----译码周期	25
3． EX----执行周期	27
4． EX----访存周期	29
5． EX----写回阶段	31
六、 加分项2：用Verilog实现该CPU，并仿真验证其功能。	33
（一） 设计文件，模块介绍	33
1． CPU(CPU.v)	33
2． CPU接口管理模块（CPU_export）	33
3． 取指阶段（取指模块Fetch）：	34
4． 执行阶段(Decode模块)	34
5． 执行阶段(Execute模块)	34
6． 执行阶段(Access模块)	34
7． 执行阶段(WriteBack模块）	34
（二） 仿真文件介绍，分析	35
1． 对每个模块进行单独的仿真测试	35
2． 整体测试中，十条指令样例给定的数据环境	39
（三） verilog源代码	55
1． CPU.v	55
2． CPU_export.v	58
3． Clock.v	62
4． Fetch.v	64
5． Execute.v	65
6． Access.v	67
7． WriteBack.v	70
8． CPU_export_read.v	72
9． CPU_export_write.v	73
10． Clock_tb.v	75
11． Fetch_tb.v	76
12． Decode_tb.v	77
13． Execute_tb.v	79

加分项1：IO接口，加分项2：verilog设计并仿真 均已完成

# verilog仿真结果

可查看报告

![image-20230515201112229](https://farsblog.oss-cn-beijing.aliyuncs.com/PicGo/202305152011300.png)

