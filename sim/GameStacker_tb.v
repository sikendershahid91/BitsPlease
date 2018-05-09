`timescale 1 ns / 1 ns

module GameStacker_tb();
	reg [0:0] clk, rst;
	reg [2:0] _buttons;
	reg [15:0] _userid; 
	reg [1:0] _gamestate;

	wire [0:0] _game_eog; 
	wire [31:0] _game_data; 

	GameStacker game(
		.clk(clk), 
		.rst(rst), 
		.buttons(_buttons), 
		.userid(_userid),
		.gamestate(_gamestate), 
		.game_eog(_game_eog),
		.game_display(/* empty*/),
		.game_data(_game_data));  


	always begin
		#10 clk = ~clk; 
	end

	always @ (_buttons) begin
		if(_buttons[0] == 1) begin
			$display(" button is pressed "); 
			#10 @(posedge clk) _buttons[0] =0;
			$display(" button is released"); 
		end
	end

	always @(_game_eog) begin
		if(_game_eog === 1'b1) begin
			$display(" EOG was reached");
			_gamestate = 2'b00;
		end
		else if(_game_eog ===1'b0) begin
			_gamestate = 2'b01;
		end
	end

	initial begin
		$monitor("[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n****************", 
			game.game_table[0],
			game.game_table[1],
			game.game_table[2],
			game.game_table[3], 
			game.game_table[4], 
			game.game_table[5],
			game.game_table[6],
			game.game_table[7]);

		clk = 1; rst = 1; 
		_buttons = 3'b000; 
		_userid = 16'h1476; 
		_gamestate = 2'b00; 

		#10 @(posedge clk) _gamestate = 2'b01; 
		#30 @(posedge clk) _buttons[0] = 1; 
		#120 @(posedge clk) _buttons[0] = 1; 
		//#10 @(posedge clk) _gamestate = 2'b01; 



	end

endmodule 