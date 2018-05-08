

module GameStacker(
	input [0:0] clk, // timer
	input [0:0] rst,
	input [2:0] buttons,
	input [15:0] userid,
	input [1:0] gamestate,
	output reg [0:0] game_eog,
	//output reg [7:0] timer_reconfig_fb,
	output [63:0] game_display,
	output [31:0] game_data);

	reg [7:0] game_table[7:0]; 
	reg [15:0] game_score; 
	reg [2:0] lineIndex, xCount, stackPos;
	reg direction;

	parameter INIT = 0, SHIFT = 1, PLACE = 2, INC = 3, EOG = 4;
	reg [3:0] State; 

	always @ (posedge clk) begin
		if(!rst) begin
			State <= INIT; 
		end
		else begin
			case(State)
				INIT: begin
					game_table[0] = 8'b00000000; 
					game_table[1] = 8'b00000000;
					game_table[2] = 8'b00000000;
					game_table[3] = 8'b00000000;
					game_table[4] = 8'b00000000;
					game_table[5] = 8'b00000000;
					game_table[6] = 8'b00000000; 
					game_table[7] = 8'b00000000;
					lineIndex <= 0;
					xCount <= 0;
					stackPos <= 0;
					direction <= 0;
					game_eog <= 0;
					if((gamestate === 2'b01) begin
						State <= SHIFT;
					end

				end
				SHIFT: begin
					if(buttons[0] == 1) begin
						State <= PLACE;
					end
					else begin
						if(direction == 0) begin
							xCount <= xCount + 1;
							game_table[lineIndex] <= game_table[lineIndex] >> 1;
						end
						else if (direction == 1) begin
							xCount <= xCount - 1;
							game_table[lineIndex] <= game_table[lineIndex] << 1;
						end
						
						if (xCount == 6)begin
							direction <= 1;
						end
						else if (xCount == 1) begin
							direction <= 0;
						end
						
						if(lineIndex == 0) begin
							stackPos <= xCount;
						end
					end
				end
				PLACE: begin
					if(stackPos == xCount) begin
						State <= INC;
					end
					else begin
						State <= EOG;
					end
				end
				INC: begin
					if(lineIndex < 8) begin
						lineIndex <= lineIndex + 1;
						xCount <= 0;
						stackPos <= 0;
						direction <= 0;
						State <= SHIFT;
					end
					else begin
						State <= EOG;
					end
					game_score <= game_score + 1 + (7 - lineIndex); 	// why
				end
				EOG: begin
					game_eog <= 1;
				end
				default: begin
					State <= INIT;
				end
			endcase
		end
	end

	assign game_data = {userid, game_score};
	assign game_display ={
		game_table[7],
		game_table[6],
		game_table[5],
		game_table[4],
		game_table[3],
		game_table[2],
		game_table[1],
		game_table[0]
	};


endmodule 