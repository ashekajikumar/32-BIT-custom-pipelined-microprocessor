							     CUSTOM 32-BIT PIPELINED MICROPROCESSOR							    |
																			    |
	    																		    |
																			    |
	       GLOBAL PARAMETERS:															    |
																			    |
ADDRESS_WIDTH          ---> 32 BITS															    |
DATA WIDTH             ---> 32 BITS															    |
DATA ACCESS TYPE       ---> BYTE ADDRESSABLE LITTLE ENDIAN												    |
NO. OF PIPELINE STAGES ---> 5																    |
NO. OF INSTRUCTIONS    ---> 16(including NOP)														    |
																			    |
																			    |
																			    |
----------------------------------------------------------|----------------------------------------------|--------------------------------------------------|
	             INSTRUCTION SET                      |                BRANCH CONDITIONS             | 	          ALU control signals	            | 
					  		  |				        	 |					            |
	Mnenomic     Opcode		  	   	  | 	Branch operation     condition bits      |	  ALU Operation    Control signal	    |
					  		  |				        	 |						    |
	NOP     ---> 00000  (no operation)		  |	   	BCS	 --->    0000	       	 |     		ADD	--->	000		    |
	ADD     ---> 00001  (adds two numbers)	   	  |	   	BCC      --->    0001	       	 |		SUB	--->	001	            |
	SUB	---> 00010  (subtracts two numbers) 	  |	   	BEQ	 --->    0010	       	 |		AND	--->	010	            |
	AND	---> 00011  (bitwise and of two numbers)  |	   	BNE	 --->    0011	       	 |		OR	--->	011		    |
	OR	---> 00100  (bitwise or of two numbers)   |	   	BVC	 --->    0100	       	 |		NOT	--->	100		    |
	NOT	---> 00101  (bitwise not of one number)   |	   	BVS	 --->    0101	       	 | 		XOR	--->	101		    |
	XOR	---> 00110  (bitwise xor of two numbers)  |	   	BNC      --->    0110	       	 |		BUFFER  --->    110		    |
	LI	---> 01000  (loads 16 bits)		  |	   	BNS	 --->    0111	       	 |	        			    	    |
	ORI	---> 01001  (used with LI to load 32 bits)|				        	 |						    |
	LD	---> 01010  (loads data from memory)	  |				        	 |						    |
	SD	---> 01011  (stores data into memory) 	  |				        	 |						    |
	J	---> 01100  (jumps to given address)	  |				        	 | 						    |
	JAL	---> 01101  (jump to different function)  |				        	 | 						    |
	JR	---> 01110  (stores PC value )		  |				        	 |						    |
	BXX	---> 01111  (Branch instruction)          |				        	 | 	 					    |
	CMP	---> 10000  (Compares two values for BXX) |				        	 |						    |
					  		  |				        	 |						    |	
					  		  |				        	 |  						    |
----------------------------------------------------------|----------------------------------------------|--------------------------------------------------|
									CONTROL SIGNALS									    |			
																			    |
MemToReg : Chooses either result from ALU or data read from memory to be written back to a register							    |
MemWrite : Sets to 1 for store word instructions to write data to memory										    |
MemRead  : Sets to 1 for load word instructions to read data from memory to be loaded onto a register 							    |
ALUsrc1  : Chooses the first operand for ALU operation													    |
ALUsrc2  : Chooses the second operand for ALU operation													    |
RegWrite : Sets to 1 when data has to written back into register											    |
Jump     : Sets to 1 if instruction is any of the jump(J,JAL,JR) instructions 										    |
Branch   : Sets to 1 if instruction is a branch instruction												    |
JAL      : Chooses between ALU result or PC to be written back to register incase of a function call							    |
RegRead  : Sets to 1 when data has to be read from Register file											    |
ALUop    : Given to the ALU to perform necessary operation												    |
																			    |
																			    |
------------------------------------------------------------------------------------------------------------------------------------------------------------|
																			    |			 
						              INSTRUCTION FIELDS									    |
																			    |
> ADD,SUB,AND,OR,NOT,XOR                                                                  >SD								    |
    bits 31-27 : OPcode									      bits 31-27 : OPcode					    |	
    bits 26-22 : Destination register 							      bits 26-22 : destination register				    |
    bits 21-17 : Source Register 1                                                            bits 21-17 : index register(for address)			    |
    bit 16    : I(set if second operand is immediate value)                                  bits 16-0  : 17 bit index register offset value		    |
    bits 15-11 : Source Register 2															    |
    bits 15-0  : 16 bit Immediate value															    |
																			    |
>LI										          >J								    |
    bits 31-27 : OPcode 								      bits 31-27 : OPcode					    |
    bits 26-22 : Destination Register							      bits 26-22 : index register(for address)			    |
    bits 21-6  : 16 bit immediate value							      bits 21-0  : offset value for index register		    |
    bits 5-0   : dont care								      								    |
																			    |
>ORI											  >JAL/JR							    |
    bits 31-27 : OPcode 								      bits 31-27 : OPcode					    |
    bits 26-22 : Destination register and source register 1				      bits 26-22 : register to store PC+4			    |
    bits 21-6  : 16 bit immediate value							      bits 21-17 : index register (for address)			    |
    bits 5-0   : dont care								      bits 16-0  : 17 bit offset for index register		    |
																			    |
>LD											  >BXX								    |
    bits 31-27 : OPcode									      bits 31-27 : OPcode					    |
    bits 26-22 : destination register							      bits 26-23 : condition bits			            |
    bits 21-17 : index register(for address)						      bits 22-0  : PC relative offset				    |
    bits 16-0  : 17 bit index register offset value					      								    |
																			    |																			    
>CMP																			    |
    bits 31-27 : Opcode																	    |
    bits 26-22 : source register 1															    |
    bits 21-17 : source register 2															    |
    bit 16     : I(1 if second operand is immediate value)												    |
    bits 15-0  : 16 bit immediate value															    |
																			    |
------------------------------------------------------------------------------------------------------------------------------------------------------------|