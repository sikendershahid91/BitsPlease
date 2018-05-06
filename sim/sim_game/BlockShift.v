module BlockShift(blockLoc, stopBtn, adjClkPulse, newBlockLoc);
	input [7:0] blockLoc;
	input stopBtn;
	input adjClkPulse;
	output [7:0] newBlockLoc;

	reg [7:0] tempBlock;
	reg [7:0] tempBlock2;

	reg state;
	parameter s_init = 0, s_shift = 1;
	reg enable;

	always @ (posedge adjClkPulse) begin
		case(state)
			s_init: begin
				if(enable == 1) begin
					tempBlock <= blockLoc;
					enable <= 0;
				end
				else begin
					tempBlock2 <= tempBlock;
				end
				state <= s_shift;
			end
			s_shift: begin
				tempBlock2 <= tempBlock >> 1;
				state <= s_init;
			end
			default: begin
				state <= s_init;
				enable <= 1;
			end
	end

	assign newBlockLoc = tempBlock;
endmodule
