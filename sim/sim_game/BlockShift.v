module BlockShift(blockLoc, stopBtn, adjClkPulse, newBlockLoc);
	input [7:0] blockLoc;
	input stopBtn;
	input adjClkPulse;
	output [7:0] newBlockLoc;

	reg [7:0] tempBlock;
	reg [7:0] tempBlock2;

	reg state;
	parameter s_init = 0, s_shift = 1;
	reg enable, direction;
	reg [2:0] xCount;

	always @ (posedge adjClkPulse) begin
		case(state)
			s_init: begin
				if(enable == 1) begin
					tempBlock <= blockLoc;
					enable <= 0;
				end
				state <= s_shift;
			end
			s_shift: begin
				if(direction == 0) begin
					xCount <= xCount + 1;
					tempBlock <= tempBlock >> 1;
				end
				else if (direction == 1) begin
					xCount <= xCount - 1;
					tempBlock <= tempBlock << 1;
				end
				
				if (xCount == 6)begin
					direction <= 1;
				end
				else if (xCount == 1) begin
					direction <= 0;
			
				state <= s_init;
			end
			default: begin
				state <= s_init;
				enable <= 1;
			end
		endcase
	end

	assign newBlockLoc = tempBlock;
endmodule
