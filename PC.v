module PC(
	clk_i,
	rst_i,
	start_i,
	pc_i,
	pc_o,
	hd_i  // 1'b01 if stall
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
input   [31:0]      pc_i;
input               hd_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;


always@(posedge clk_i or negedge rst_i or hd_i) begin
    if(hd_i) begin
	pc_o <= 32'b0
    else
    	if(~rst_i) begin
     	   pc_o <= 32'b0;
    	end
    	else begin
    	    if(start_i)
    	        pc_o <= pc_i;
    	    else
    	        pc_o <= pc_o;
    	end
    end
end

endmodule
