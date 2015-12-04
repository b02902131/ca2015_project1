module ALU{
	.data1_i,
	.data2_i,
	.ALUControl_i,
	.data_o
};

//Ports
input   [31:0]  data1_i, data2_i;
input   [2:0]   ALUControl_i;
output  [31:0]  data_o;

always @(data1_i or data2_i or ALUControl_i)begin
    case(ALUControl_i)
        3'b010: data_o = data1_i + data2_i; //add
        3'b110: data_o = data1_i - data2_i; //sub
        3'b001: data_o = data1_i | data2_i; //or
        3'b000: data_o = data1_i & data2_i; //and
        3'b100: data_o = data1_i * data2_i; //mul
        
        3'b111: //slt
        begin   
            if( data1_i < data2_i)
                data_o = 32'b00000000000000000000000000000001;
            else 
                data_o = 32'b00000000000000000000000000000000;
        end
        default: data_o = 32'b00000000000000000000000000000000;
    endcase
end

endmodule


