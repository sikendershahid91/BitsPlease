//sikender

module BitsPlease(
	input [0:0]  clk, 
	input [0:0]  rst,
	input [2:0]  PushButtons, 
	input [17:0] ToggleSwitch 
	output [1:0] LED; // LED[0] = red led LED[1] = green led

	//outputs for  7segmentdisplay, 
	//outputs for  matrix 
	//outputs for  LCD, 
	); 

	/*

	buttons : shaped and decoded by the process control
	switches: controled by the process control to allow I/O 

	*/ 
	wire [2:0] push_buttons_shaped; 
	ButtonShaper b1(clk, PushButtons[0], push_buttons_shaped[0]), 
				 b2(clk, PushButtons[1], push_buttons_shaped[1]),
				 b3(clk, PushButtons[2], push_buttons_shaped[2]);

	wire [2:0] button_process_control,
			   button_access_control,
			   button_game, 
			   button_scoreboard;
	ButtonDecoder button_decoder(
		.Select(button_select), 
		.ButtonVector(push_buttons_shaped), 
		.ButtonVector1(button_process_control),
		.ButtonVector2(button_access_control), 
		.ButtonVector3(button_game), 
		.ButtonVector4(button_scoreboard)); 
	
	wire[17:0] Switches; 
	SwitchesControl sw(switches_select,ToggleSwitch,Switches); 

	/*

	process control : main control for the game

	*/ 
	wire [0:0] switches_select; 
	wire [2:0] button_select;
	wire [1:0] score_select; 
	wire [3:0] LCD_select; 
	wire [15:0] userid_const;  
	wire [0:0]  userinput_load;  
	ProcessControl process_control(
		.clk(clk),
		.rst(rst),  
		.buttons(button_process_control), 
		.access_control_fb(access_grant), 
		.game_fb(/*  */), 
		.scoreboard_fb(/*  */), 
		.buttons_select(button_select),
		.switches_select(switches_select), 
		.lcd_control(LCD_select),
		.led_control(LED),
		.userid(userid_const), 
		.game_score_select(score_select));

	/*

	access control : password and login 

	*/
	wire [0:0] access_grant;
	AccessControl access_control(
		.clk(clk),
		.rst(rst), 
		._Data_In({2'b00,Switches[15:0]}), 
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
	wire [31:0] display_wire;
	DisplayScoreMux mux(
		score_select, 
		game_score, 
		score_board_scores, 
		display_wire); 
		
endmodule 
