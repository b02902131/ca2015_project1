module EX_MEM{
	.clk_i,
	.WB_i,
	.WB_o,
	.M_i,
	.M_o_1,
	.M_o_2,
	.ALU_i,
	.ALU_o,
	.MUX7_i,
	.MUX7_o,	//WriteData_o
	.MUX3_i,
	.MUX3_o
}

//ports
input clk_i;
input   [2:0]   M_i;
input   WB_i, ALU_i, MUX7_i, MUX3_i;
output  WB_o, M_o_1, M_o_2, ALU_o, MUX7_o, MUX3_o;

always @(posedge clk_i)begin
    WB_o = WB_i;
    //TODO: M_o!
    M_o_1 = M_i[1];
    M_o_2 = M_i[0];
    ALU_o = ALU_i;
    MUX7_o = MUX7_i;
    MUX3_o = MUX3_i;
end
endmodule
