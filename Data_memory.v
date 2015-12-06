module Data_Memory(
	MemWrite_i,
	MemRead_i,
	Addr_i,
	WriteData_i,
	ReadData_o
);

// Interface
input   [31:0]      Addr_i, WriteData_i;
output  reg [31:0]      ReadData_o;
input   MemWrite_i, MemRead_i;
integer addr0, i;
// Data memory
reg     [7:0]     memory  [0:31];

always @(MemWrite_i or MemRead_i or Addr_i or WriteData_i)begin
	addr0 = Addr_i>>2;
	if(MemWrite_i) begin
		memory[addr0] = WriteData_i[7:0];
		memory[addr0+1] = WriteData_i[15:8];
		memory[addr0+2] = WriteData_i[23:16];
		memory[addr0+3] = WriteData_i[31:24];
	end		
	if(MemRead_i) begin
		ReadData_o[7:0] = memory[addr0];
		ReadData_o[15:8] = memory[addr0+1];
		ReadData_o[23:16] = memory[addr0+2];
		ReadData_o[31:24] = memory[addr0+3];
	end
end
endmodule

