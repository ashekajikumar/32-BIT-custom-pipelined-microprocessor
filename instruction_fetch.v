module instruction_fetch(
	input clk,
	input PC2_stall,PC_stall,
	input jump, //jump control signal
	input [31:0] jump_address,
	input [1:0] stall_flush_IR2,
	output reg [31:0] PC,
	output reg [31:0] PC2,
	output reg [31:0] IR2,
	output [31:0] PC_next,
	output reg [31:0] IR
	);

wire [31:0] PC_next1;
reg [7:0] instruction_memory[0:255];
reg [31:0] PC_plus_4;
reg [31:0] PC_temp;


initial begin
	PC<=0;
	
end

initial begin
// li $1,10        //{instruction_memory[3],instruction_memory[2],instruction_memory[1],instruction_memory[0]}=32'b01000000010000000000001010000000;
// li $2,5         //{instruction_memory[7],instruction_memory[6],instruction_memory[5],instruction_memory[4]}=32'b01000000100000000000000101000000;
// cmp $1,$2       //{instruction_memory[11],instruction_memory[10],instruction_memory[9],instruction_memory[8]}=32'b10000000010001000000000000000000;
// beq address 20  //{instruction_memory[15],instruction_memory[14],instruction_memory[13],instruction_memory[12]}=32'b01111001000000000000000000000100;
// sub $1,$1,1     //{instruction_memory[19],instruction_memory[18],instruction_memory[17],instruction_memory[16]}=32'b00010000010000110000000000000001;
// j address 8     //{instruction_memory[23],instruction_memory[22],instruction_memory[21],instruction_memory[20]}=32'b01100000000000000000000000001000;
// li $2,10        //{instruction_memory[27],instruction_memory[26],instruction_memory[25],instruction_memory[24]}=32'b01000000100000000000001010000000;

  end

assign PC_next={32{~PC_stall}}&(PC_next1) | {32{PC_stall}}&(PC);
assign PC_next1={32{~jump}}&(PC_plus_4) | {32{jump}}&(jump_address);

always@( negedge clk)
begin
	if (PC==32'b0000 || PC==32'b0100)
		PC=PC_plus_4;
	else
		begin
		PC=PC_next;
		end
	IR={instruction_memory[PC_temp+3],instruction_memory[PC_temp+2],instruction_memory[PC_temp+1],instruction_memory[PC_temp]};
end


always@(posedge clk)
begin
	case(stall_flush_IR2)
	2'b00:	IR2<=IR;
	2'b01:	IR2<=32'bx;
	2'b10:	IR2<=IR2;
	endcase
end

always@(posedge clk)
begin
PC2={32{~PC2_stall}}&(PC+4) | {32{PC2_stall}}&(PC2);
end

always@(posedge clk)
begin
	PC_plus_4<=PC+4;
	PC_temp<=PC;

end

endmodule
	
	