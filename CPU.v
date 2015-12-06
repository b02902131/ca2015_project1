module CPU(
	clk_i,
	start_i
);

input	clk_i,start_i;

wire	[31:0]	Add_PC_o, PC_o, IF_ID_PC_o;
wire	[31:0]	MUX7_o, MUX1_o, MUX5_o;
wire 	[31:0]	EX_MEM_ALU_o , ID_EX_inst1_o;
wire	[31:0]	inst;
wire	[31:0]	Sign_o;
wire	[8:0]	MUX8_o;
wire	[4:0]	ID_EX_inst4_o;
wire 	[31:0]	Reg_RS, Reg_RT;
wire	[4:0]	MEM_WB_MUX3_o, EX_MEM_MUX3_o;
wire 	[2:0]	ID_EX_M_o;
wire	[1:0]	EX_MEM_WB_o;
wire	JUMP;
wire	MEM_WB_WB_o_1;
wire	and_gate_o, and_gate1_i, and_gate2_i;			
and	and_gate(and_gate_o, and_gate1_i, and_gate2_i);		//and_gate2_i = branch

wire 	or_gate_o;
or	or_gate(or_gate_o, JUMP, and_gate_o);

wire	[31:0]	Jump_address;
wire	[27:0]	Shift26_o;
assign	Jump_address[27:0] = Shift26_o;
assign 	Jump_address[31:28] = MUX1_o[31:28];

Adder Add_PC(
	.data1_in	(PC_o),
	.data2_in	(32'd4),
	.data_o		(Add_PC_o)
);

Adder Add(
	.data1_in	(Shift.data_o),
	.data2_in	(IF_ID_PC_o),
	.data_o		(MUX1.data1_i)
);

//MUX5 MUX32_2 MUX32_3 MUX2_6

MUX32_2 MUX1(
	.data1_i	(Add.data_o),
	.data2_i	(Add_PC_o),
	.control_i	(and_gate_o),				
	.data_o		(MUX1_o)
);

MUX32_2 MUX2(
	.data1_i	(MUX1_o),
	.data2_i	(Jump_address),
	.control_i	(JUMP),
	.data_o		(PC.pc_i)
);

MUX5_2 MUX3(
	.data1_i	(ID_EX_inst4_o),
	.data2_i	(ID_EX.inst5_o),
	.control_i	(ID_EX.EX_o_3),
	.data_o		(EX_MEM.MUX3_i)
);

MUX32_2 MUX4(
	.data1_i	(MUX7_o),
	.data2_i	(ID_EX_inst1_o),
	.control_i	(ID_EX.EX_o_1),
	.data_o		(ALU.data2_i)
);

MUX32_2 MUX5(
	.data1_i	(MEM_WB.ReadData_o),
	.data2_i	(MEM_WB.addr_o),
	.control_i	(MEM_WB.WB_o_2),
	.data_o		(MUX5_o)
);

MUX32_3 MUX6(
	.data1_i	(ID_EX.MUX6_o),
	.data2_i	(MUX5_o),
	.data3_i	(EX_MEM_ALU_o),
	.control_i	(FW.MUX6_o),
	.data_o		(ALU.data1_i)
);

MUX32_3 MUX7(
	.data1_i	(ID_EX.MUX7_o),
	.data2_i	(MUX5_o),
	.data3_i	(EX_MEM_ALU_o),
	.control_i	(FW.MUX7_o),
	.data_o		(MUX7_o)
);
//MUX8 maybe 7 input
MUX8 MUX8(
	.data1_i	(Control.MUX8_o),
	.data2_i	(9'd0),
	.control_i	(HD.MUX8_o),
	.data_o		(MUX8_o)
);

PC PC(
	.clk_i	(clk_i),
	.start_i(start_i),
	.pc_i	(MUX2.data_o),
	.pc_o	(PC_o),
	.hd_i	(HD.PC_o)
);

Instruction_Memory Instruction_Memory(
	.addr_i	(PC_o),
	.instr_o(IF_ID.ReadData_i)
);

Registers Registers(
	.clk_i		(clk_i),
	.RSaddr_i   	(inst[25:21]),
    	.RTaddr_i	(inst[20:16]),
    	.RDaddr_i  	(MEM_WB_MUX3_o), 
    	.RDdata_i	(MUX5_o),
    	.RegWrite_i 	(MEM_WB_WB_o_1), 
   	.RSdata_o   	(Reg_RS), 
    	.RTdata_o   	(Reg_RT)
);

Shift Shift(
	.data_i		(Sign_o),
	.data_o		(Add.data1_in)
);

Shift26 Shift26(
	.data_i		(inst[25:0]),
	.data_o		(Shift26_o)
);


Sign_Extend Sign_Extend(
	.data_i	(inst[15:0]),
	.data_o	(Sign_o)
);

Eq Eq(
	.data1_i	(Reg_RS),
	.data2_i	(Reg_RT),
	.data_o		(and_gate1_1)
);

HD HD(
	.ID_EX_M_i	(ID_EX_M_o[1]),
	.IF_ID_o	(IF_ID.HD_i),
	.inst_i		(inst),
	.MUX8_o		(MUX8.control_i),
	.ID_EX_inst4	(ID_EX_inst4_o),
	.PC_o		(PC.hd_i)
);

Control Control(
	.Op_i		(inst[31:26]),
	.MUX8_o		(MUX8.data1_i),
	.Branch_o	(and_gate2_i),
	.Jump_o		(JUMP)
);

ALU ALU(
	.data1_i	(MUX6.data_o),
	.data2_i	(MUX4.data_o),
	.ALUControl_i	(ALU_Control.ALUCtrl_o),
	.data_o		(EX_MEM.ALU_i)
);

ALU_Control ALU_Control(
	.funct_i	(ID_EX_inst1_o[5:0]),
	.ALUOp_i	(ID_EX.EX_o_2),
	.ALUCtrl_o	(ALU.ALUControl_i)
	
);

//clockwise: 123456

FW FW(
	.data1_i	(EX_MEM_MUX3_o),
	.data2_i	(EX_MEM_WB_o[1]),
	.data3_i	(MEM_WB_MUX3_o),
	.data4_i	(MEM_WB_WB_o_1),
	.data5_i	(ID_EX.inst3_o),
	.data6_i	(ID_EX.inst2_o),
	.MUX6_o		(MUX6.control_i),
	.MUX7_o		(MUX7.control_i)	
);

Data_Memory Data_Memory(
	.MemWrite_i	(EX_MEM.M_o_2),
	.MemRead_i	(EX_MEM.M_o_1),
	.Addr_i		(EX_MEM_ALU_o),
	.WriteData_i	(EX_MEM.MUX7_o),
	.ReadData_o	(MEM_WB.ReadData_i)
);


IF_ID IF_ID(
    .clk_i  (clk_i),
	.PC_i		(Add_PC_o),
	.PC_o		(IF_ID_PC_o),
	.ReadData_i	(Instruction_Memory.instr_o),
	.ReadData_o	(inst),
	.HD_i		(HD.IF_ID_o),
	.Flush_i	(or_gate_o)
);

ID_EX ID_EX(
	.clk_i	(clk_i),
	.WB_i		(MUX8_o[8:7]),
	.WB_o		(EX_MEM.WB_i),
	.M_i		(MUX8_o[6:4]),
	.M_o		(ID_EX_M_o),
	.EX_i		(MUX8_o[3:0]),
	.EX_o_1		(MUX4.control_i),
	.EX_o_2		(ALU_Control.ALUOp_i),
	.EX_o_3		(MUX3.control_i),
	.PC_i		(IF_ID_PC_o),
	.ReadData1_i	(Reg_RS),	//RS
	.ReadData2_i	(Reg_RT),	//RT
	.inst1_i	(Sign_o),
	.inst2_i	(inst[25:21]),
	.inst3_i	(inst[20:16]),
	.inst4_i	(inst[20:16]),
	.inst5_i	(inst[15:11]),
	.MUX6_o		(MUX6.data1_i),
	.MUX7_o		(MUX7.data1_i),
	.inst1_o	(ID_EX_inst1_o),	//MUX4_o
	.inst2_o	(FW.data6_i),
	.inst3_o	(FW.data5_i),
	.inst4_o	(ID_EX_inst4_o),
	.inst5_o	(MUX3.data2_i)
);

EX_MEM EX_MEM(
	.clk_i	(clk_i),
	.WB_i		(ID_EX.WB_o),
	.WB_o		(EX_MEM_WB_o),
	.M_i		(ID_EX_M_o),
	.M_o_1		(Data_Memory.MemRead_i),
	.M_o_2		(Data_Memory.MemWrite_i),
	.ALU_i		(ALU.data_o),
	.ALU_o		(EX_MEM_ALU_o),
	.MUX7_i		(MUX7_o),
	.MUX7_o		(Data_Memory.WriteData_i),	//WriteData_o
	.MUX3_i		(MUX3.data_o),
	.MUX3_o		(EX_MEM_MUX3_o)
);

MEM_WB MEM_WB(
	.clk_i	(clk_i),
	.WB_i		(EX_MEM_WB_o),
	.WB_o_1		(MEM_WB_WB_o_1),
	.WB_o_2		(MUX5.control_i),	//MemToReg
	.ReadData_i	(Data_Memory.ReadData_o),
	.ReadData_o	(MUX5.data1_i),
	.addr_i		(EX_MEM_ALU_o),
	.addr_o		(MUX5.data2_i),
	.MUX3_i		(EX_MEM_MUX3_o),
	.MUX3_o		(MEM_WB_MUX3_o)
);

endmodule
