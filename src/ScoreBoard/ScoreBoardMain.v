//sikender

module ScoreBoardMain(
	input clk, 
	input rst, 
	input [2:0] buttons,
	input [15:0] user_id,
	input [15:0] score, 
	input [1:0] game_state,
	output [0:0] scoreboard_eof,
	output [31:0] display_data); 

	wire [0:0] wren_wire; 
	wire [15:0] address_wire;
	wire [15:0] data_wire;
	wire [15:0] ram_data_wire;

	wire [0:0] parity_wire;
	wire [31:0]scoreboard_data;  

	RAMScoreboard RAM(
		.clk(clk),
		._Address(address_wire),
		._Data_In(data_wire),
		.wren(wren_wire),
		._Data_Out(ram_data_wire)); 

	ScoreBoard scoreboard(
		.clk(clk),
		.rst(rst),
		.userid(user_id),
		.game_state(game_state),
		.score_data(score),
		.ram_data(ram_data_wire),
		.scoreboard_output(scoreboard_data),
		.scoreboard_parity(parity_wire),
		.wren(wren_wire),
		.address(address_wire),
		.data(data_wire)); 

	ScoreBoardDisplay scoreboard_display(
		.clk(clk),
		.rst(rst),
		.data(scoreboard_data),
		.buttons(buttons),
		.parity_toggle(parity_wire),
		.scoreboard_eof(scoreboard_eof),
		.userid_score_output(display_data)); 

endmodule

