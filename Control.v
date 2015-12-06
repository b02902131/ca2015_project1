module Control(
	Op_i,
	MUX8_o,
	Branch_o,
	Jump_o
);

input [5:0] Op_i;
reg RegWrite_o, MemtoReg_o;
reg RegDst_o, ALUSrc_o;
reg MemWrite, MemRead;
reg [1:0] ALUOp_o;
output reg [8:0] MUX8_o;	// [8:7] WB, [6:4] M, [3:0] EX
output reg Jump_o, Branch_o;



always@(Op_i) begin
	MemtoReg_o = 1'b0;	// 1 : only when lw
	MemRead = 1'b0;		// 1 : only when lw
	MemWrite = 1'b0;	// 1 : only when sw
	Branch_o = 1'b0;	// 1 : only when beq
	Jump_o = 1'b0;		// 1 : only when jump
	RegWrite_o = 1'b0;	// 1 : when R-type or lw or I-type
	if(Op_i == 6'b000000) begin	//R-type
		RegWrite_o = 1'b1;
		RegDst_o = 1'b1;
		ALUOp_o = 2'b10;
		ALUSrc_o = 1'b0;
	end
	else if(Op_i == 6'b100011) begin	// lw
		RegWrite_o = 1'b1;
		MemtoReg_o = 1'b1;
		MemRead = 1'b1;
		RegDst_o = 1'b0;
		ALUOp_o = 2'b00;
		ALUSrc_o = 1'b1;
	end
	else if(Op_i == 6'b101011) begin	// sw
		MemtoReg_o = 1'bx;
		MemWrite = 1'b1;
		RegDst_o = 1'bx;
		ALUOp_o = 2'b00;
		ALUSrc_o = 1'b1;
	end 
	else if(Op_i == 6'b000100) begin	// beq
		MemtoReg_o = 1'bx;
		RegDst_o = 1'bx;
		ALUOp_o = 2'b01;
		ALUSrc_o = 1'b0;
		Branch_o = 1'b1;	// change value only here
	end 
	else if(Op_i == 6'b000010) begin	// jump
		MemtoReg_o = 1'bx;
		RegDst_o = 1'bx;
		ALUOp_o = 2'bxx;
		ALUSrc_o = 1'bx;
		Jump_o = 1'b1;		// change value only here
	end
	else if(Op_i == 6'b001000) begin	// addi
		RegWrite_o = 1'b1;
		RegDst_o = 1'b0;
		ALUOp_o = 2'b00;
		ALUSrc_o = 1'b1;
	end

	MUX8_o[8] = RegWrite_o;
	MUX8_o[7] = MemtoReg_o;
	MUX8_o[5] = MemRead;
	MUX8_o[4] = MemWrite;
	MUX8_o[3] = RegDst_o;
	MUX8_o[2:1] = ALUOp_o;
	MUX8_o[0] = ALUSrc_o;

end

endmodule
