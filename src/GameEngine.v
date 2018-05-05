// GAME ENGINE
// Description: Takes a button input and stops a single block.
// Checks to see if the block is on the stack.
// Comments/Log: None.

module gameEngine (clk, rstBtn,dropBtn,timer, lineDisplay,);

	input clk, rstBtn;
	input dropBtn;
	input timer;
	output reg [7:0]lineDisplay[0:7];
	parameter INIT = 0, MOVE = 1, STOP = 2, CHECK = 3, FAIL = 4, UPDATE = 5;
	
	reg [2:0] State;
	reg [2:0] lineNum;
	reg [2:0] xCount;
	reg direction;		// 0 is right, 1 is left
	
// FSM BEGINS
	always @(posedge clk) begin
		if (rstBtn == 0) begin
			lineDisplay[0] <= 0;		// Assuming 0 is lowest line of the LED Matrix
			lineDisplay[1] <= 0;
			lineDisplay[2] <= 0;
			lineDisplay[3] <= 0;
			lineDisplay[4] <= 0;
			lineDisplay[5] <= 0;
			lineDisplay[6] <= 0;
			lineDisplay[7] <= 0;
			lineNum <= 0;
			xCount <=0;
			direction <= 0;
			State <= INIT;
		end
		else begin
			case(State)
				INIT: begin
					lineDisplay[lineNum] <= 8'b10000000;
					State <= MOVE;
				end
				MOVE: begin
					if(dropBtn == 1) begin
						State <= CHECK;
					end
					else begin
						if(timer == 1) begin						
							if(direction == 0) begin
								xCount <= xCount + 1;
								lineDisplay[lineNum] <= lineDisplay[lineNum] >> 1;
							end
							else if (direction == 1) begin
								xCount <= xCount - 1;
								lineDisplay[lineNum] <= lineDisplay[lineNum] << 1;
							end
							
							if (xCount == 7)begin
								direction <= 1;
							end
							else if (xCount == 0)
								direction <= 0;
							end
						end
						else begin 
							State <= MOVE; 
						end
					end		
				end
				STOP: begin
				
				end
				CHECK: begin
				end
				FAIL: begin
				end
				UPDATE: begin
				end
			endcase
		end
	end

endmodule 