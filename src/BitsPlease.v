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

	/*

	buttons : shaped and decoded by the process control 

	*/ 
	wire [2:0] push_buttons_shaped; 
	ButtonShaper b1(clk, PushButtons[0], push_buttons_shaped[0]), 
				 b2(clk, PushButtons[1], push_buttons_shaped[1]),
				 b3(clk, PushButtons[2], push_buttons_shaped[2]);

	

	wire [2:0] button_process_control,
			   button_game, 
			   button_scoreboard;
	ButtonDecoder button_decoder(
		.Select(button_select), 
		.ButtonVector(push_buttons_shaped), 
		.ButtonVector1(button_process_control),
		.ButtonVector2(button_game), 
		.ButtonVector3(button_scoreboard) 
		); 
	
	/*

	process control : main control for the game

	*/ 
	wire [2:0] button_select;
	wire [1:0] score_select; 
	wire [15:0] userinput_data;
	wire [15:0] userid_const;  
	wire [0:0] userinput_load;  
	ProcessControl process_control(
		.clk(clk),
		.rst(rst), 
		.switches(ToggleSwitch), 
		.buttons(button_process_control), 
		.access_control_fb(access_grant), 
		.game_fb(/*  */), 
		.scoreboard_fb(/*  */), 
		.buttons_select(button_select), 
		.userinput(userinput_data), 
		.load(userinput_data), 
		.lcd_control(),
		.led_control(/*  */),
		.userid(/*  */), 
		.game_score_select(score_select) 
		);


	/*

	access control : password and login 

	*/
	wire [0:0] access_grant;
	AccessControl access_control(
		.clk(clk),
		.rst(rst), 
		._Data_In({1'b0,userinput_data}), 
		._Data_In_Load(userinput_load),
		._Access_grant(access_grant)); 
		 

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
