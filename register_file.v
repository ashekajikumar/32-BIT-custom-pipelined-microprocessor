module register_file(
	input clk,
	input [4:0] RA1,RA2,WA,
	input write_enable,
	input read_enable,
	input [31:0] write_data,
	output reg [31:0] RD1,RD2,
	output [31:0] R1,R2,R3,R4,R5,R6
	);
	
reg [31:0] reg_array [0:31];
assign R1=reg_array[1];
assign R2=reg_array[2];
assign R3=reg_array[3];
assign R4=reg_array[4];
assign R5=reg_array[5];
assign R6=reg_array[6];

initial begin
	reg_array[0]=32'b0000;
	reg_array[1]=32'b0011;
	reg_array[2]=32'b1011;
	reg_array[3]=32'b0001;
	reg_array[4]=32'b11010;
	reg_array[5]=32'b1010;
	reg_array[6]=32'b0000;
	
end
always@(negedge clk)
begin
	case(read_enable)
	1'b1:		begin
				RD1=reg_array[RA1];
				RD2=reg_array[RA2];
				end
				
	1'b0:		begin
				RD1<=32'bx;
				RD2<=32'bx;
				end
	default:	begin
				RD1<=32'bx;
				RD2<=32'bx;
				end
				
	endcase
end

always@(WA,write_data)
begin
	if (write_enable==1)
	begin
		reg_array[WA]=write_data;
	end
end

endmodule