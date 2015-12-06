module IF_ID(
	PC_i,
	PC_o,
	ReadData_i,
	ReadData_o,
	HD_i,
	Flush_i,
    	clk_i
);

//Ports
input   PC_i;
input 	[31:0]	ReadData_i;
input   HD_i, Flush_i, clk_i;
output reg PC_o;
output reg [31:0]	ReadData_o;

always @(posedge clk_i)begin
   if(HD_i == 1'b0) begin   		//can sent to the next step
	if(Flush_i ==1'b0)begin
	   PC_o = PC_i;
	   ReadData_o = ReadData_i;
	else
	   PC_o = 1'b0;
	   ReadData_o = 32'b0;
   end

end

endmodule
