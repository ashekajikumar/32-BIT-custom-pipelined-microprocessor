module flush_stall(
	input cond3,Jump3,
	input [31:0] IR2,IR3,
	output reg  [1:0] stall_flush_IR2,
	output reg stall_flush_IR3,
	output reg stall_flush,
	output reg PC2_stall,PC_stall
	
	);
	

wire flush_cond;
reg stall_cond;
assign flush_cond = cond3 | Jump3;

always@(*)
begin
	stall_flush<=stall_cond | flush_cond;
end


initial begin
stall_flush_IR2<=2'b00;
stall_flush_IR3<=0;
stall_flush<=0;
PC2_stall<=0;
PC_stall<=0;
end


always@(*)
begin
	if (IR3[31:27]==5'b01010 && (IR2[31:27]==5'b00001 || IR2[31:27]==5'b00010 || IR2[31:27]==5'b00011 || IR2[31:27]==5'b00100 || IR2[31:27]==5'b00101 || IR2[31:27]==5'b00110))
		begin
		if(IR3[26:22]==IR2[21:17] || IR3[26:22]==IR2[15:11])
			begin
			stall_cond=1;
			end
		end
	
	else if (IR3[31:27]==5'b01010 && IR2[31:27]==5'b10000)
		begin
			if (IR3[26:22]==IR2[26:22] || IR3[26:22]==IR2[21:17])
			begin
				stall_cond=1;
			end
		end
		
		
	else if (IR3[31:27]==5'b10000 && IR2[31:27]==5'b01111)
		stall_cond=1;
		
	else
		stall_cond=0;
	
end




always@(*)
begin
	if (flush_cond==1)
	begin
		stall_flush_IR2<=2'b01;
		stall_flush_IR3<=1'b1;
	end
	
	else if (stall_cond==1)
		begin
		stall_flush_IR2<=2'b10;
		stall_flush_IR3<=1'b1;
		PC2_stall<=1'b1;
		PC_stall<=1'b1;
		end
	else 
		begin
		stall_flush_IR2<=2'b00;
		stall_flush_IR3<=1'b0;
		PC2_stall<=1'b0;
		PC_stall<=1'b0;
		end
end

endmodule