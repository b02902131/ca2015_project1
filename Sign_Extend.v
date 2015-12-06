module Sign_Extend(
	data_i,
	data_o
);

input[15:0] data_i;
output reg [31:0] data_o;

always@(data_i) begin
	data_o[31:16] = {8{data_i[15]}};
	data_o[15:0] = data_i[15:0];
end

endmodule
