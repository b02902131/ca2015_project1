module Data_memory{
	.MemWrite_i,
	.MemRead_i,
	.Addr_i,
	.WriteData_i,
	.ReadData_o
};

// Interface
input   [31:0]      Addr_i, WriteData_i;
output  [31:0]      ReadData_o;
input   MemWrite_i, MemRead_i;

// Data memory
reg     [31:0]     memory  [0:8];

always @(MemWrite_i or MemRead_i or Addr_i or WriteData_i)begin
    if(MemWrite_i)
        memory[Addr_i>>2] = WriteData_i;
    if(MemRead_i)
        ReadData_o = memory[Addr_i>>2];  
end
endmodule

