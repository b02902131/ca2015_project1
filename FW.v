module FW{
	.data1_i,
	.data2_i,
	.data3_i,
	.data4_i,
	.data5_i,
	.data6_i,
	.MUX6_o,
	.MUX7_o	
};

//data1: EX/MEM.Rd
//data2: EX/MEM.RegWrite
//data3: MEM/WB.Rd
//data4: MEM/WB.RegWrite
//data5: ID/EX.Rt
//data6: ID/EX.Rs
//MUX6 : ForwardA
//MUX7 : ForwardB
input   data1_i,data2_i,data3_i,data4_i,data5_i,data6_i;
output  MUX6_o, MUX7_o;


always @(data1_i or data2_i or data3_i or data4_i or data5_i or data6_i)begin
    //ForwardA
    //if (EX/MEM.RegWrite) and (EX/MEM.RegisterRd ≠ 0) and (EX/MEM.RegisterRd=ID/EX.RegisterRs))  ForwardA = 10 
    if(data2_i == 2'b1x and data1_i != 5'b00000 and data1_i==data6_i)
        MUX6_o == 2'b10;
    //if (MEM/WB.RegWrite) and (MEM/WB.RegisterRd ≠ 0) and (MEM/WB.RegisterRd=ID/Ex.RegisterRs))   ForwardA = 01 
    else if(data4_i == 2'b1x and data3_i != 5'b00000 and data3_i == data6_i)
        MUX6_o == 2'b01;
    else
        MUX6_o == 2'b00;

    //ForwardB
    //if (EX/MEM.RegWrite) and (EX/MEM.RegisterRd ≠ 0) and (EX/MEM.RegisterRd=ID/Ex.RegisterRt))   ForwardB = 10 
    if( data2_i == 2'b1x and data1_i = 5'b00000 and data1_i == data5_i)
        MUX7_o == 2'b10;
    //if (MEM/WB.RegWrite) and (MEM/WB.RegisterRd ≠ 0) and (MEM/WB.RegisterRd=ID/Ex.RegisterRt))   ForwardB = 01 
    else if(data4_i == 2'b1x and data3_i != 5'b00000 and data3_i == data5_i)
        MUX7_o == 2'b01;
    else
        MUX7_o == 2'b00;
end

endmodule
