module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input [5:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;

reg [2:0] ALUCtrl_o;

always@(funct_i, ALUOp_i) begin
	case(ALUOp_i)
		2'b00: ALUCtrl_o = 3'b010;	//add
		2'b01: ALUCtrl_o = 3'b110;	//sub
		2'b10: ALUCtrl_o = 3'b001;	//or
		2'b11:
		case(funct_i)
			6'b100000: ALUCtrl_o = 3'b010;	//add
			6'b100010: ALUCtrl_o = 3'b110;	//sub
			6'b100100: ALUCtrl_o = 3'b000;	//and
			6'b100101: ALUCtrl_o = 3'b001;	//or
			6'b011000: ALUCtrl_o = 3'b100;	//mul
			6'b101010: ALUCtrl_o = 3'b111;	//slt
		endcase
	endcase
end

endmodule


