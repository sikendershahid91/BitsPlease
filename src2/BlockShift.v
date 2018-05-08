module BlockShift(start, blockLoc, stopBtn, adjClkPulse, newBlockLoc, startNext);
	input start;
	input [7:0] blockLoc;
	input stopBtn;
	input adjClkPulse;
	output [7:0] newBlockLoc;
	output reg startNext;

	reg [7:0] tempBlock;
	reg [7:0] strBlock;

	reg [1:0] state;
	parameter s_init = 0, s_shift = 1, s_pause = 2;
	reg enable, direction;
	reg [2:0] xCount;

	always @ (posedge adjClkPulse) begin
		//start signal to start shifting
		//possibly a switch
		//otherwise stay not lit.
		if(start == 1) begin
			//when first row
			// send out signal when stop is pressed for the next inst
			case(state)
				s_init: begin
					if(enable == 1) begin
						tempBlock <= blockLoc;
						enable <= 0;
					end
					state <= s_shift;
				end
				s_shift: begin
					if (stopBtn == 1) begin
						state <= s_pause;
						//Do checks on if there is anything below
					end
					else begin
						if(direction == 0) begin
							xCount <= xCount + 1;
							tempBlock <= tempBlock >> 1;
						end
						else if(direction == 1)begin
							xCount <= xCount - 1;
							tempBlock <= tempBlock << 1;
							if(tempBlock == 8'b1000000) begin
								direction <= 0;
							end
						end
						if (xCount == 6)begin
							direction <= 1;
						end
						else if (xCount == 0) begin
							direction <= 0;
						end
						state <= s_shift;
					end
				end
				s_pause: begin
					strBlock <= tempBlock;
					startNext <= 1;
					state <= s_pause;
				end
				default: begin
					enable <= 1;
					xCount <= 0;
					direction <= 0;
					state <= s_init;
				end
			endcase
		end
		else begin
			tempBlock <= 8'b00000000;
			startNext <= 0;
		end
	end

	assign newBlockLoc = tempBlock;

endmodule
