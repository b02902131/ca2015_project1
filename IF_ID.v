module IF_ID(
	PC_i,
	PC_o,
	ReadData_i,
	ReadData_o,
	HD_i,
	Flush_i,
	Flush_o,
    	clk_i
);

//Ports
input   [31:0]	PC_i;
input 	[31:0]	ReadData_i;
input   HD_i, Flush_i, clk_i;
output	reg Flush_o;
output reg [31:0]	PC_o;
output reg [31:0]	ReadData_o;

always @(posedge clk_i)begin
   Flush_o = 1'b0;
   if(HD_i == 1'b1) begin
	PC_o = PC_o;
	ReadData_o = ReadData_o;
   end
   else begin   		//can sent to the next step
	if(Flush_i ==1'b1)begin
	   PC_o = 1'b0;
	   ReadData_o = 32'b0;
	   Flush_o = Flush_i;
	end
	else begin
	   PC_o = PC_i;
	   ReadData_o = ReadData_i;
	end
   end
end

endmodule
