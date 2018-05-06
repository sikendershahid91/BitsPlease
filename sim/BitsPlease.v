//sikender

module BitsPlease(
	input [0:0]  clk, 
	input [0:0]  rst,
	input [2:0]  PushButtons, 
	input [17:0] ToggleSwitch 
	//output 7segmentdisplay, 
	//output matrix 
	//output LCD, 
	); 

	wire [2:0] push_buttons_shaped; 
	ButtonShaper b1(clk, PushButtons[0], push_buttons_shaped[0]), 
				 b2(clk, PushButtons[1], push_buttons_shaped[1]),
				 b3(clk, PushButtons[2], push_buttons_shaped[2]);

	/*

	process control : main control for the game

	*/ 

	wire [2:0] button_select;
	wire [1:0] score_select;  
	ProcessControl process_control(
		);


	wire [2:0] button_access_control,
			   button_game, 
			   button_scoreboard;
	ButtonDecoder button_decoder(
		.Select(button_select), 
		.ButtonVector(push_buttons_shaped), 
		.ButtonVector1(button_access_control),
		.ButtonVector2(button_game), 
		.ButtonVector3(button_scoreboard) 
		); 

	/*

	access control : password and login 

	*/
	

	/*

	game modules : "tetris"

	*/
	wire [31:0] game_score; 

	/*
	
	score board: 

	*/
	wire [31:0] score_board_scores; // will be larger 


	/* 

	display

	*/
	wire [31:0] display_wire = (score_select)? game_score:score_board_scores; 
		//change this ^ for 0 to be ground 
		

	

endmodule 
