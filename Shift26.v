module Shift{
	data_i,
	data_o
};

input [25:0] data_i;
output [27:0] data_o;

always
begin
	data_o[27:2] = data_i[25:0]; 
end

endmodule