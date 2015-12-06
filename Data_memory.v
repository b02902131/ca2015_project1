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
// Data memory
reg     [7:0]     memory  [0:31];

always @(MemWrite_i or MemRead_i or Addr_i or WriteData_i)begin
	if(MemWrite_i) begin
		memory[Addr_i] = WriteData_i[7:0];
		memory[Addr_i+1] = WriteData_i[15:8];
		memory[Addr_i+2] = WriteData_i[23:16];
		memory[Addr_i+3] = WriteData_i[31:24];
	end		
	if(MemRead_i) begin
		ReadData_o[7:0] = memory[Addr_i];
		ReadData_o[15:8] = memory[Addr_i+1];
		ReadData_o[23:16] = memory[Addr_i+2];
		ReadData_o[31:24] = memory[Addr_i+3];
	end
end
endmodule

