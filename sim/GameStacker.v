

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

	parameter INIT = 0, 
			  SHIFT = 1, 
		      PLACE = 2, 
			  EOG = 4;

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
					lineIndex <= 7;
					direction <= 0;
					game_score <= 0; 
					game_eog <= 0; 
					if(gamestate == 2'b01) begin  // begin game 
						game_table[lineIndex] <= 8'b10000000;
						State <= SHIFT;
					end else begin
						State <= INIT; 
					end
				end
				SHIFT: begin
					if(buttons[0] !== 1'b1) begin
						//shift
						if(game_table[lineIndex] == 8'b00000000) begin
							game_table[lineIndex] <= 8'b10000000;
						end else if(game_table[lineIndex] !== 8'b00000001 && direction == 0) begin 
							game_table[lineIndex] <= game_table[lineIndex] >> 1;
						end else if(game_table[lineIndex] !== 8'b10000000 && direction == 1) begin
							game_table[lineIndex] <= game_table[lineIndex] << 1; 
						end else if (game_table[lineIndex] === 8'b00000001) begin
							direction <=1; 
						end else if (game_table[lineIndex] === 8'b10000000) begin
							direction <=0; 
						end else begin
							// do nothing actually 
						end
						State <= SHIFT; 
					end else begin
						State <= PLACE; 
					end
				end
				PLACE: begin

					if(game_table[lineIndex+1] == game_table[lineIndex] || lineIndex == 7) begin
						lineIndex <= lineIndex -1;
						game_score <= game_score + 1 + (7 - lineIndex);  
						State <= SHIFT; 
					end else begin
						State <= EOG; 
					end
				end
				EOG: begin
					game_eog <= 1;
					State <= INIT; // needs to be handeld in  case of new game.. handled by always block
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