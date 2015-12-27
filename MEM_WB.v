module MEM_WB(
	clk_i,
	WB_i,
	WB_o_1,
	WB_o_2,	//MemToReg
	ReadData_i,
	ReadData_o,
	addr_i,    
	addr_o,
	MUX3_i,
	MUX3_o,
	stall
);


//WB_o_1 : RegWrite
//WB_o_2 : MemToReg
input   clk_i, stall;
input   [1:0]   WB_i;
input   [31:0] ReadData_i;
output reg WB_o_1, WB_o_2;
output reg [31:0] ReadData_o;
input   [31:0] addr_i;
input   [4:0]  MUX3_i;
output reg [31:0] addr_o;
output reg [4:0]  MUX3_o;


//10 //11 lw //00 bubble
always @(posedge clk_i)begin
	if(stall == 1'b1) begin
		
	end
	else begin
    WB_o_1 = WB_i[1];
    addr_o = addr_i;
    ReadData_o = ReadData_i;
    MUX3_o = MUX3_i;
    WB_o_2 = WB_i[0];
	end
end
endmodule     

