module memory_access(
	input clk,
	input [31:0] IR4,PC4,Z4,S4,
	input MemToReg4,MemWrite4,MemRead4,RegWrite4,JAL4,
	input forward_sw_mem,
	input [4:0] RA1_4,RA2_4,WA_4,
	output reg [31:0] Z5,
	output reg [31:0] IR5,
	output reg RegWrite5,
	output [31:0] S4_1
	);
reg [31:0] read_data1;
wire [31:0] read_data2;
reg [7:0] data_mem [0:255];
initial begin
	{data_mem[3],data_mem[2],data_mem[1],data_mem[0]}=32'b00000000000000000000000000001001;
	end

assign S4_1={32{~forward_sw_mem}}&(S4) | {32{forward_sw_mem}}&(Z5);
assign read_data2={32{~JAL4}}&(Z4) | {32{JAL4}}&(PC4) ;
always@(posedge clk)
begin
	
	 Z5 <= {32{~MemToReg4}}&(read_data2) | {32{MemToReg4}}&(read_data1);
	 IR5<=IR4;
	 RegWrite5<=RegWrite4;
end



always@(MemRead4,MemWrite4)
begin
	if (MemRead4==1)
		read_data1<={data_mem[Z4+3],data_mem[Z4+2],data_mem[Z4+1],data_mem[Z4]};
	
	else if (MemWrite4==1)
		{data_mem[Z4+3],data_mem[Z4+2],data_mem[Z4+1],data_mem[Z4]}=S4_1;
		
end


endmodule
	
	