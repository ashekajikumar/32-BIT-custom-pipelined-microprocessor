module execution(
	input clk,
	input cond3,
	input [31:0] IR3,PC3,X3,Y3,S3,imm3,
	input MemToReg3,MemWrite3,MemRead3,ALUsrc1_3,ALUsrc2_3,RegWrite3,Jump3,JAL3,
	input [2:0] ALUop3,
	input [31:0] Z5,
	input [4:0] RA1_3, RA2_3,WA_3,
	input forward1_ex,forward2_ex,forward_sw_ex,z4_z5_sw_ex,z4_z5_logical_1,z4_z5_logical_2,
	output [31:0] jump_address,
	output jump,
	output reg [31:0] Z4,
	output reg [31:0] IR4,PC4,
	output reg [31:0] S4,
	output reg [3:0] CC4,
	output reg MemToReg4,MemWrite4,MemRead4,RegWrite4,JAL4,
	output reg [4:0] RA1_4,RA2_4,WA_4,
	output [31:0] RS1,RS2,
	output reg [32:0] result,
	output [31:0] RS1_1, RS2_1,
	output [31:0] z4_z5_sw_op
	);
	

wire [31:0] z4_z5_logical_op_1;
wire [31:0] z4_z5_logical_op_2;
assign jump_address=result[31:0];	 
assign jump=Jump3 | cond3;
	



always@(posedge clk)
begin
	 RA1_4<=RA1_3;
	 RA2_4<=RA2_3;
	 WA_4<=WA_3;
	 MemToReg4<=MemToReg3;
	 MemWrite4<=MemWrite3;
	 MemRead4<=MemRead3;
	 RegWrite4<=RegWrite3;
	 JAL4<=JAL3;
	 PC4<=PC3;
	 IR4<=IR3;
end

assign RS1_1={32{~ALUsrc1_3}}&(PC3) | {32{ALUsrc1_3}}&(X3);
assign RS2_1={32{~ALUsrc2_3}}&(imm3) | {32{ALUsrc2_3}}&(Y3);
assign z4_z5_logical_op_1={32{~z4_z5_logical_1}}&(Z4) |{32{z4_z5_logical_1}}&(Z5);
assign z4_z5_logical_op_2={32{~z4_z5_logical_2}}&(Z4) |{32{z4_z5_logical_2}}&(Z5);
assign RS1={32{~forward1_ex}}&(RS1_1) | {32{forward1_ex}}&(z4_z5_logical_op_1);
assign RS2={32{~forward2_ex}}&(RS2_1) | {32{forward2_ex}}&(z4_z5_logical_op_2);
assign z4_z5_sw_op={32{~z4_z5_sw_ex}}&(Z4) | {32{z4_z5_sw_ex}}&(Z5);


always@(posedge clk)
begin
	 
	 Z4<=result[31:0];
	 S4<={32{~forward_sw_ex}}&(S3) | {32{forward_sw_ex}}&(z4_z5_sw_op);

end


always@(RS1,RS2)
begin
	case(ALUop3)
	3'b000:	result<=RS1+RS2;
	3'b001:	begin
				
					result<=RS1-RS2;
				end
	3'b010:	result<=RS1&RS2;
	3'b011:	result<=RS1|RS2;
	3'b100:	result<=~RS1;
	3'b101:	result<=RS1^RS2;
	3'b110:	result<=RS2;
	default:	result<=33'bx;
	endcase
	
end

always@(negedge  clk)
begin
	if (IR3[31:27]==5'b10000)
					begin
						if (result==0)
							CC4<=4'b0001;  //zero
						else if (result[31]==1)
							CC4<=4'b0010;   //negative
						else if (result[32]==1)
							CC4<=4'b1000;  //carry
						else if (((result[32]==1)&(RS1[31]==0)&(RS2[31]==1)) |  ((result[32]==0)&(RS1[31]==1)&(RS2[31]==0)))
							CC4<=4'b0100;   //overflow
						
					end
					
	else
					begin
						CC4<=4'bxxxx;
					end
end


endmodule
