module Shift{
	data_i,
	data_o
};

input data_i;
output data_o;

assign data_o = data_i << 2;

endmodule