//little endian

module pipeline (
	input clk
	
);

//fetch
wire jump;
wire[31:0] jump_address;
wire [31:0] PC2,IR2;
wire [31:0] PC;
wire [31:0] PC_next;
wire [31:0] IR;

//decode
wire[3:0] CC4;
wire cond3;
wire [31:0] X3,Y3,S3,imm3,IR3,PC3;
wire MemToReg3,MemWrite3,MemRead3,ALUsrc1_3,ALUsrc2_3,RegWrite3,Jump3,JAL3;
wire [2:0] ALUop3;
wire [4:0] RA1_3,RA2_3,WA_3;
wire [4:0] RA1_2,RA2_2,WA_2;
wire RegRead;

//execute
wire [31:0] IR4,PC4,Z4,S4;
wire MemToReg4,MemWrite4,MemRead4,RegWrite4,JAL4;
wire [4:0] RA1_4,RA2_4,WA_4;
wire [31:0] RS1_1, RS2_1;
wire [31:0] z4_z5_sw_op;

//mem access
wire [31:0] Z5,IR5;
wire RegWrite5;
wire [31:0] S4_1;

//writeback
wire [31:0] R1,R2,R3,R4,R5,R6;


//data forward
wire forward1_ex,forward2_ex,forward_sw_mem,forward_sw_ex,z4_z5_sw_ex,z4_z5_logical_1,z4_z5_logical_2;

//stall flush
wire  [1:0] stall_flush_IR2;
wire stall_flush_IR3,stall_flush,PC2_stall,PC_stall;



wire [31:0] RS1,RS2; 

wire [31:0] RD1,RD2;   

wire [32:0] result;



register_file u1(.clk(clk), .RA1(RA1_2), .RA2(RA2_2), .WA(IR5[26:22]), .write_enable(RegWrite5), .read_enable(RegRead),
						.write_data(Z5), .RD1(RD1), .RD2(RD2),  .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6));

instruction_fetch i_f(.clk(clk), .jump(jump), .jump_address(jump_address),
							 .PC(PC), .PC2(PC2), .IR2(IR2), .PC2_stall(PC2_stall), .PC_stall(PC_stall),
							 .stall_flush_IR2(stall_flush_IR2), .PC_next(PC_next), .IR(IR));

instruction_decode i_d(.clk(clk), .CC4(CC4), .PC2(PC2), .IR2(IR2), .cond3(cond3), .X3(X3), .Y3(Y3), .S3(S3),
							  .imm3(imm3), .IR3(IR3), .PC3(PC3), .MemToReg3(MemToReg3), .MemWrite3(MemWrite3),
							  .MemRead3(MemRead3), .ALUsrc1_3(ALUsrc1_3), .ALUsrc2_3(ALUsrc2_3),
							  .RegWrite3(RegWrite3), .Jump3(Jump3), .JAL3(JAL3), .ALUop3(ALUop3),
							  .stall_flush(stall_flush), .stall_flush_IR3(stall_flush_IR3), .RA1_3(RA1_3),
							  .RA2_3(RA2_3), .WA_3(WA_3), .RA1_2(RA1_2),
							  .RA2_2(RA2_2), .WA_2(WA_2), .RD1(RD1), .RD2(RD2), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6),
							  .RegRead(RegRead) );

execution e(.clk(clk),.cond3(cond3), .X3(X3), .Y3(Y3), .S3(S3), .imm3(imm3), .IR3(IR3), .PC3(PC3), .MemToReg3(MemToReg3), .MemWrite3(MemWrite3),
							  .MemRead3(MemRead3), .ALUsrc1_3(ALUsrc1_3), .ALUsrc2_3(ALUsrc2_3),
							  .RegWrite3(RegWrite3), .Jump3(Jump3), .JAL3(JAL3), .ALUop3(ALUop3),
							  .jump_address(jump_address),  .jump(jump),
							  .IR4(IR4), .PC4(PC4), .Z4(Z4), .S4(S4), .CC4(CC4), .MemToReg4(MemToReg4),
							  .MemWrite4(MemWrite4), .MemRead4(MemRead4), .RegWrite4(RegWrite4),
							  .JAL4(JAL4), .Z5(Z5), .RA1_3(RA1_3),
							  .RA2_3(RA2_3), .WA_3(WA_3), .RA1_4(RA1_4),
							  .RA2_4(RA2_4), .WA_4(WA_4), .forward1_ex(forward1_ex), .forward2_ex(forward2_ex),
						     .forward_sw_ex(forward_sw_ex), .z4_z5_sw_ex(z4_z5_sw_ex), .z4_z5_logical_1(z4_z5_logical_1), .z4_z5_logical_2(z4_z5_logical_2), .RS1(RS1), .RS2(RS2),
							  .result(result), .RS1_1(RS1_1), .RS2_1(RS2_1),.z4_z5_sw_op(z4_z5_sw_op));

memory_access m_a(.clk(clk), .IR4(IR4), .PC4(PC4), .Z4(Z4), .S4(S4), .MemToReg4(MemToReg4),
							  .MemWrite4(MemWrite4), .MemRead4(MemRead4), .RegWrite4(RegWrite4),
							  .JAL4(JAL4), .Z5(Z5), .IR5(IR5),
							  .RegWrite5(RegWrite5), .RA1_4(RA1_4),
							  .RA2_4(RA2_4), .WA_4(WA_4), .forward_sw_mem(forward_sw_mem), .S4_1(S4_1));

//write_back w_b(.Z5(Z5), .IR5(IR5), .RegWrite5(RegWrite5), .clk(clk), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6));


flush_stall f_s(.cond3(cond3), .Jump3(Jump3), .IR2(IR2), .IR3(IR3), .stall_flush_IR2(stall_flush_IR2),
			   .stall_flush_IR3(stall_flush_IR3), .stall_flush(stall_flush), .PC2_stall(PC2_stall),
			   .PC_stall(PC_stall));
				
data_forward d_f(.clk(clk), .RA1_2(RA1_2), .RA1_3(RA1_3), .RA1_4(RA1_4), .RA2_2(RA2_2), .RA2_3(RA2_3), .RA2_4(RA2_4),
					  .WA_2(WA_2), .WA_3(WA_3), .WA_4(WA_4), .IR2(IR2), .IR3(IR3), .IR4(IR4),
					  .forward1_ex(forward1_ex), .forward2_ex(forward2_ex), .forward_sw_mem(forward_sw_mem),
					  .forward_sw_ex(forward_sw_ex), .z4_z5_sw_ex(z4_z5_sw_ex), .z4_z5_logical_1(z4_z5_logical_1), .z4_z5_logical_2(z4_z5_logical_2));





endmodule