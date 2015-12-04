module ID_EX{
	.clk_i,
	.WB_i,
	.WB_o,
	.M_i,
	.M_o,
	.EX_i,
	.EX_o_1,
	.EX_o_2,
	.EX_o_3,
	.PC_i,
	.ReadData1_i,	//RS
	.ReadData2_i,	//RT
	.inst1_i,
	.inst2_i,
	.inst3_i,
	.inst4_i,
	.inst5_i,
	.MUX6_o,
	.MUX7_o,
	.inst1_o,	//MUX4_o
	.inst2_o,
	.inst3_o,
	.inst4_o,
	.inst5_o
};

input clk_i;
input   WB_i, M_i, EX_i, PC_i, ReadData1_i, ReadData2_i;
output  WB_o, M_o, EX_o_1, EX_o_2, EX_o_3;
input   inst1_i, inst2_i, inst3_i, inst4_i, inst5_i;
output  inst1_o, inst2_o, inst3_o, inst4_o, inst5_o;
output  MUX6_o, MUX7_o;


always(posedge clk_i)begin
    WB_o = WB_i;
    M_o = M_i;
    //TODO EX!!
    inst1_o = inst1_i;
    inst2_o = inst2_i;
    inst3_o = inst3_i;
    inst4_o = inst4_i;
    inst5_o = inst5_i;
    MUX6_o  = ReadData1_i;
    MUX7_o  = ReadData2_i;
end

endmodule


