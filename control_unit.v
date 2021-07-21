module control_unit(
	input [4:0] opcode,input I,stall_flush,
	output reg MemToReg,MemWrite,MemRead,ALUsrc1,ALUsrc2,RegWrite,Jump,Branch,JAL,RegRead,
	output reg [2:0] ALUop
	);
	
always@(opcode)
	begin
		if (stall_flush==0)
				begin
						case(opcode)
						5'b00001:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b000;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end
											
						
						5'b00010:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b001;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end	
												
												
						5'b00011:		begin	
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b010;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end	
												
												
						5'b00100:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b011;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end	
												
												
						5'b00101:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b100;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end	
												
												
						5'b00110:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b101;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end
												
						5'b01000:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1'bx;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=0;
											ALUop<=3'b110;
											ALUsrc2<=0;
											end
											
											
						5'b01001:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b011;
											ALUsrc2<=0;
											end
											
											
						5'b01010:		begin
											MemToReg<=1;
											MemWrite<=0;
											MemRead<=1;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b000;
											ALUsrc2<=0;
											end
											
											
											
						5'b01011:		begin
											MemToReg<=0;
											MemWrite<=1;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=0;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b000;
											ALUsrc2<=0;
											end
											
											
											
						5'b01100:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=0;
											Jump<=1;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b000;
											ALUsrc2<=0;
											end
											
											
											
						5'b01101:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=1;
											Jump<=1;
											Branch<=0;
											JAL<=1;
											RegRead<=1;
											ALUop<=3'b000;
											ALUsrc2=0;
											end
											
						5'b01110:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=0;
											Jump<=1;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b000;
											ALUsrc2<=0;
											end
											
											
						5'b01111:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=0;
											RegWrite<=0;
											Jump<=0;
											Branch<=1;
											JAL<=0;
											RegRead<=0;
											ALUop<=3'b000;
											ALUsrc2<=0;
											end
											
											
											
						5'b10000:		begin
											MemToReg<=0;
											MemWrite<=0;
											MemRead<=0;
											ALUsrc1<=1;
											RegWrite<=0;
											Jump<=0;
											Branch<=0;
											JAL<=0;
											RegRead<=1;
											ALUop<=3'b001;
											if (I==1)
												ALUsrc2<=0;
											else
												ALUsrc2<=1;
											end
								
						default:			begin
											MemToReg<=1'bx;
											MemWrite<=1'bx;
											MemRead<=1'bx;
											ALUsrc1<=1'bx;
											ALUsrc2<=1'bx;
											RegWrite<=1'bx;
											Jump<=1'b0;
											Branch<=1'bx;
											JAL<=1'bx;
											RegRead<=1'bx;
											ALUop<=3'bxxx;
											end
								
						endcase
						
						
				end
		

		else
				begin
						MemToReg<=1'bx;
						MemWrite<=1'bx;
						MemRead<=1'bx;
						ALUsrc1<=1'bx;
						ALUsrc2<=1'bx;
						RegWrite<=1'bx;
						Jump<=1'b0;
						Branch<=1'bx;
						JAL<=1'bx;
						RegRead<=1'bx;
						ALUop<=3'bxxx;
				end
end

endmodule