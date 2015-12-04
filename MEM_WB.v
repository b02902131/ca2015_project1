module MEM_WB{
	.clk_i,
	.WB_i,
	.WB_o_1,
	.WB_o_2,	//MemToReg
	.ReadData_i,
	.ReadData_o,
	.addr_i,    
	.addr_o,
	.MUX3_i,
	.MUX3_o
};


//WB_o_1 : RegWrite
//WB_o_2 : MemToReg
input   clk_i;
input   [1:0]   WB_i;
input   ReadData_i;
output  WB_o_1, WB_o_2, ReadData_o;
input   addr_i, MUX3_i;
output  addr_o, MUX3_o;


//10 //11 lw //00 bubble
always @(posedge clk_i)begin
    WB_o_1 = WB_i[1];
    addr_o = addr_i;
    ReadData_o = ReadData_i;
    MUX3_o = MUX3_i;
    WB_o_2 = WB_i[0];
end
endmodule     

