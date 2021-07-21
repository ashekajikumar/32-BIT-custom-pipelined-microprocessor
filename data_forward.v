module data_forward(
	input clk,
	input [4:0] RA1_2,RA1_3,RA1_4,
	input [4:0] RA2_2,RA2_3,RA2_4,
	input [4:0] WA_2,WA_3,WA_4,
	input [31:0] IR2,IR3,IR4,
	output reg forward1_ex,forward2_ex,forward_sw_mem,forward_sw_ex,z4_z5_sw_ex,z4_z5_logical_1,z4_z5_logical_2
	);
	
initial begin
	forward1_ex<=0;
	forward2_ex<=0;
	forward_sw_mem<=0;
	forward_sw_ex<=0;
	z4_z5_sw_ex<=0;
	z4_z5_logical_1<=0;
	z4_z5_logical_2<=0;
end

	

	
always@( posedge clk)
begin

	if (WA_4==RA1_2)
		begin
			forward1_ex=1;
			z4_z5_logical_1=1;
		end
	else
		begin
			forward1_ex=0;
			z4_z5_logical_1=0;
		end
	
		//
	if (WA_4==RA2_2)
		begin
			if (IR2[31:27]!=5'b01011)
			begin
				forward2_ex=1;
				z4_z5_logical_2=1;
			end
			
			else if (IR2[31:27]==5'b01011)
			begin
				forward_sw_ex=1;
				z4_z5_sw_ex=1;
			end
		end
		
	else
		begin
			forward2_ex=0;
			z4_z5_logical_2=0;
			forward_sw_ex=0;
			z4_z5_sw_ex=0;
		end
	
	
	
	
	
	if (IR3[31:27]!=5'b01010 )
		begin
		if (WA_3==RA1_2 )
			begin
				forward1_ex=1;
				z4_z5_logical_1=0 ;//z4
			end
			
		else if (WA_3!=RA1_2 && forward1_ex!=1)
			begin
				forward1_ex=0;
				z4_z5_logical_1=0 ;//z4
			end
		
		
		if (WA_3==RA2_2)
			begin
				if (IR2[31:27]!=5'b01011)
				begin
					forward2_ex=1;
					z4_z5_logical_2=0;  //z4
				end
				
				else if (IR2[31:27]==5'b01011)
				begin
					forward_sw_ex=1;
					z4_z5_sw_ex=0;
				end
			end
			
		else if (WA_3!=RA2_2 && forward2_ex!=1 && forward_sw_ex!=1)
			begin
				forward2_ex=0;
				z4_z5_logical_2=0;
				forward_sw_ex=0;
				z4_z5_sw_ex=0;
			end
		//	
		
		end
		
	else if (IR3[31:27]==5'b01010 && IR2[31:27]==5'b01011)
		begin
				if (WA_3==RA2_2)
					begin
						forward_sw_mem=1;
					end
				else
					begin
						forward_sw_mem=0;
					end
		end
		
	
	
	
end
	
endmodule