// GAME ENGINE
// Description: Takes a button input and stops a single block.
// Checks to see if the block is on the stack.
// Comments/Log: None.



/*


module gameEngine (clk, rstBtn,dropBtn,timer, lineDisplay, EOG);
=======
module GameEngine (clk, rstBtn,dropBtn,timer, lineDisplay, EOG);
>>>>>>> e05871c5f685dbdd7010e878cba8e1211b483ca0

	input clk, rstBtn;
	input dropBtn;
	input timer;
	output reg [7:0] lineDisplay;
	output reg EOG;
	parameter INIT = 0, MOVE = 1, STOP = 2, CHECK = 3, FAIL = 4, UPDATE = 5, WIN = 6;
	
	reg [2:0] State;
	reg [2:0] lineNum;
	reg [2:0] xCount, checkPos;
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
			xCount <= 0;
			checkPos <= 0;
			direction <= 0;
			EOG <= 0;
			State <= INIT;
		end
		else begin
			case(State)
				INIT: begin
					if(EOG == 0) begin 			// Possibly replace it with a start signal
						lineDisplay <= 8'b10000000;	// starts the block at the left most cololumn
						xCount <= 0;
						direction <= 0;
						State <= MOVE;
					end
				end
				MOVE: begin						// if the dropBtn is press we stop moving
					if(dropBtn == 1) begin
						State <= STOP;
					end
					else begin
						if(timer == 1) begin						// block moves left 7 then right 7, continoulsy at a specific timer 
							if(direction == 0) begin
								xCount <= xCount + 1;
								lineDisplay <= lineDisplay >> 1;
							end
							else if (direction == 1) begin
								xCount <= xCount - 1;
								lineDisplay <= lineDisplay << 1;
							end
							
							if (xCount == 6)begin
								direction <= 1;
							end
							else if (xCount == 1) begin
								direction <= 0;
							end
						end
						else begin 
							State <= MOVE; 
						end
					end		
				end
				STOP: begin
					if(lineNum == 0) begin
						checkPos <= xCount;
					end
					State <= CHECK;				
				end
				CHECK: begin
					if(checkPos == xCount) begin
						State <= UPDATE;			// add point system
					end
					else begin State <= FAIL; 
					end
				end
				FAIL: begin
					lineDisplay[0] <= 0;		// LED Matrix is cleared
					lineDisplay[1] <= 0;
					lineDisplay[2] <= 0;
					lineDisplay[3] <= 0;
					lineDisplay[4] <= 0;
					lineDisplay[5] <= 0;
					lineDisplay[6] <= 0;
					lineDisplay[7] <= 0;
					lineNum <= 0;				// Numbers are reset until a start signal is given
					xCount <= 0;
					checkPos <= 0;
					direction <= 0;
					EOG <= 1;					// Our control that we failed our game
					State <= INIT;				
				end
				UPDATE: begin
					if(lineNum < 8) begin			// Runs to the next LED row (8)
						lineNum <= lineNum + 1;
						State <= INIT;
					end
					else begin
						State <= WIN;
					end
				end
				WIN: begin
					EOG <= 1;					// WiP: Create some sorta of action that lets the user know of a win
				end
			endcase
		end
	end

endmodule 

*/