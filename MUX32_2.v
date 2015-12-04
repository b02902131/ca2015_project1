module MUX32_2{
	data1_i,
	data2_i,
	control_i,
	data_o
}

input [31:0] data1_i, data2_i;
input select_i;
output [31:0] data_o;
reg [31:0] data_o;

always@(data1_i or data2_i or control_i) begin
	case(control_i) 
		1'b0: data_o = data1_i;
		1'b1: data_o = data2_i;
	endcase
end

endmodule