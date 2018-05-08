

module GameStacker(
	input [0:0] clk, // timer
	input [0:0] rst,
	input [2:0] buttons,
	input [15:0] userid,
	input [1:0] gamestate,
	output reg [0:0] game_eog,
	output reg [7:0] timer_reconfig_fb,
	output [63:0] game_display,
	output [31:0] game_data);

	reg [7:0] game_table[7:0]; 
	reg [15:0] game_score; 

	parameter INIT = 0;
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