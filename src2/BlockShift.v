module BlockShift(startSw, prev, stopBtn, adjClkPulse, newBlockLoc, next);
	input stopBtn, startSw;
	input adjClkPulse;
	input [7:0] prev;
	output wire [7:0] newBlockLoc;
	output reg next;
	reg [7:0] tempBlock;

	reg [1:0] state;
	parameter s_init = 0, s_shift = 1, s_pause = 2;
	reg direction;
	reg [2:0] xCount;

	always @ (posedge adjClkPulse) begin
		if(startSw == 1) begin
			case (state)
			s_init: begin
				tempBlock <= 8'b1000000;
				direction <= 0;
				xCount <= 0;
				state <= s_shift;
			end
			s_shift: begin
				if(stopBtn == 0) begin
					state <= s_pause;
				end
				else begin
					if(direction == 0) begin
					xCount <= xCount + 1;
					tempBlock <= tempBlock>> 1;
					end
					else if(direction == 1)begin
						xCount <= xCount - 1;
						tempBlock <= tempBlock<< 1;
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
				if(prev == 0) begin
					next <= 1;
				end
				else begin
					if(prev == tempBlock) begin
						next <= 1;
					end
					else begin
						tempBlock <= 8'b00000000;
						next <= 0;
					end
				end
				state <= s_pause;
			end
			default: begin
				tempBlock <= 8'b10000000;
				direction <= 0;
				xCount <= 0;
				next <= 0;
				state <= s_init;
			end
		endcase
		end
		else begin
			tempBlock <= 8'b11111111;
			next <= 0;
		end
	end

	assign newBlockLoc = tempBlock;
endmodule
