module Shift26(
	data_i,
	data_o
);

input [25:0] data_i;
output reg [27:0] data_o;


always@(data_i) begin
	data_o[27:2] = data_i[25:0];
	data_o[1:0] = 2'b00;
end

endmodule
