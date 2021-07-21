module instruction_decode(
	input clk,
	input [3:0] CC4,
	input [31:0] PC2,IR2,
	input stall_flush,
	input  stall_flush_IR3,
	output reg [31:0] IR3,PC3,
	output reg cond3,
	output reg [31:0] X3,Y3,S3,
	output reg [31:0] imm3,
	output reg MemToReg3,MemWrite3,MemRead3,ALUsrc1_3,ALUsrc2_3,RegWrite3,Jump3,JAL3,
	output reg [2:0] ALUop3,
	output reg [4:0] RA1_3,RA2_3,WA_3,
	output reg [4:0] RA1_2,RA2_2,WA_2,
	output [31:0] RD1,RD2,
	output [31:0] R1,R2,R3,R4,R5,R6,
	output RegRead
	);
	
wire [31:0] write_data;
wire Branch;
wire MemToReg,MemWrite,MemRead,ALUsrc1,ALUsrc2,RegWrite,Jump,JAL;//,RegRead;
wire [2:0] ALUop;
reg [31:0] imm;
reg [4:0] RA1_2_temp,RA2_2_temp,WA_2_temp;


						
control_unit u2( .opcode(IR2[31:27]), .I(IR2[16]), .MemToReg(MemToReg), .MemWrite(MemWrite), 
					.MemRead(MemRead), .ALUsrc1(ALUsrc1), .ALUsrc2(ALUsrc2), .RegWrite(RegWrite),
					.Jump(Jump), .Branch(Branch), .JAL(JAL), .RegRead(RegRead), .stall_flush(stall_flush),
					.ALUop(ALUop));

initial begin
cond3<=0;
end					

always@(posedge clk)
begin
	MemToReg3=MemToReg;
	 MemWrite3=MemWrite;
	 MemRead3=MemRead;
	 ALUsrc1_3=ALUsrc1;
	 ALUsrc2_3=ALUsrc2;
	 RegWrite3=RegWrite;
	 Jump3=Jump;
	 JAL3=JAL;
	 ALUop3=ALUop;
	 IR3={32{~stall_flush_IR3}}&(IR2) | {32{stall_flush_IR3}}&(32'bx);
	 PC3=PC2;
end



always@(posedge clk)
begin
	 X3=RD1;
	 Y3=RD2;
	 S3=RD2;
	 RA1_3=RA1_2_temp;
	 RA2_3=RA2_2_temp;
	 WA_3=WA_2;
	 imm3=imm;

	 
end

always@(negedge clk)
begin
	RA1_2_temp<=RA1_2;
	RA2_2_temp<=RA2_2;
	WA_2_temp<=WA_2;
end

always@(IR2)
begin
	if (stall_flush==0)
	begin
	case(IR2[31:27])
	5'b00001:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b00010:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b00011:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b00100:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b00101:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b00110:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[15:11];
					WA_2<=IR2[26:22];
					end
					
	5'b01000:	begin
					RA1_2<=5'bx;
					RA2_2<=5'bx;
					WA_2<=IR2[26:22];
					end
					
	5'b01001:	begin
					RA1_2<=IR2[26:22];
					RA2_2<=1'bx;//
					WA_2<=IR2[26:22];
					end
					
	5'b01010:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=1'bx;//
					WA_2<=IR2[26:22];
					end
					
	5'b01011:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=IR2[26:22];
					WA_2<=IR2[26:22];
					end
					
	5'b01100:	begin
					RA1_2<=IR2[26:22];
					RA2_2<=1'bx;//
					WA_2<=1'bx;//
					end
					
	5'b01101:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=1'bx;//
					WA_2<=IR2[26:22];
					end
						
	5'b01110:	begin
					RA1_2<=IR2[21:17];
					RA2_2<=1'bx;//
					WA_2<=1'bx;
					end
					
	5'b01111:	begin
					RA1_2<=1'bx;
					RA2_2<=1'bx;
					WA_2<=1'bx;
					end
					
	5'b10000:	begin
					RA1_2<=IR2[26:22];
					RA2_2<=IR2[21:17];
					WA_2<=1'bx;
					end
	default:		begin
					RA1_2<=5'bx;
					RA2_2<=5'bx;
					WA_2<=5'bx;
					end
	endcase
	end
	else
		begin
			RA1_2<=5'bx;
			RA2_2<=5'bx;
			WA_2<=5'bx;
		end
end


always@(negedge clk)
begin
	case(IR2[31:27])
	5'b00001:		imm<={{16{IR2[15]}},IR2[15:0]};  
	5'b00010:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b00011:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b00100:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b00101:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b00110:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b01000:		imm<={{16{1'b0}},IR2[21:6]};
	5'b01001:		imm<=IR2[21:6]<<16;
	5'b01010:		imm<={{15{IR2[16]}},IR2[16:0]};	
	5'b01011:		imm<={{15{IR2[16]}},IR2[16:0]};
	5'b01100:		imm<={{10{IR2[21]}},IR2[21:0]};	
	5'b01101:		imm<={{15{IR2[16]}},IR2[16:0]};
	5'b01110:		imm<={{16{IR2[15]}},IR2[15:0]};
	5'b01111:		imm<={{9{IR2[22]}},IR2[22:0]};	
	5'b10000:		imm<={{16{IR2[15]}},IR2[15:0]};
	default:			imm<=32'bx;
	endcase
end



always@(posedge clk)
begin
	if (Branch==1)
		begin
			case(IR2[26:23])
			4'b0000:		if (CC4[3]==1)
								begin
								cond3<=1;
								end
								
			4'b0001:		if (CC4[3]==0)
								begin
								cond3<=1;
								end
								
								
			4'b0010:		if (CC4[0]==1)
								begin
								cond3<=1;
								end
								
								
			4'b0011:		if (CC4[3]==0)
								begin
								cond3<=1;
								end
								
								
			4'b0100:		if (CC4[2]==0)
								begin
								cond3<=1;
								end
								
								
			4'b0101:		if (CC4[2]==1)
								begin
								cond3<=1;
								end
								
								
			4'b0110:		if (CC4[1]==0)
								begin
								cond3<=1;
								end
								
								
			4'b0111:		if (CC4[1]==1)
								begin
								cond3<=1;
								end
								
			default:		begin
							cond3<=1'b0;
							end
			endcase
		end
	else
		begin
			cond3<=1'b0;
		end
		
end


endmodule
			
		