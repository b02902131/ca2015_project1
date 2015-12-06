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
input   PC_i, ReadData_i, HD_i, Flush_i, clk_i;
output reg PC_o, ReadData_o;

always @(posedge clk_i)begin
   if(Flush_i == 1'b1) begin   
	   PC_o = PC_i;
	   ReadData_o = ReadData_i;
	end

end

endmodule
