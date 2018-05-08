//sikender

module BitsPlease(
	input [0:0]  clk, 
	input [0:0]  rst,
	input [2:0]  PushButtons, 
	input [17:0] ToggleSwitch, 
	
	//outputs for LED status
	output [1:0] LED, // LED[0] = red led LED[1] = green led
	//outputs for  7segmentdisplay, 
	output [6:0] display_0,
	output [6:0] display_1,
	output [6:0] display_2,
	output [6:0] display_3,
	output [6:0] display_4,
	output [6:0] display_5,
	output [6:0] display_6,
	output [6:0] display_7,
	//outputs for  matrix 
	output [7:0] matrix_row,
 	output [7:0] matrix_col,
	//outputs for  LCD, 
	output lcd_RS,
	output lcd_RW,
	output lcd_E,
	output [7:0 ]lcd_DB,
	output lcd_ON
	); 

	wire [2:0]  push_buttons_shaped; 
	wire [2:0]  button_process_control,
			    button_access_control,
			    button_game, 
			    button_scoreboard;
    wire [17:0] Switches; 
    wire [0:0]  switches_select; 
	wire [2:0]  button_select;
	wire [1:0]  score_select; 
	wire [3:0]  LCD_select; 
	wire [15:0] userid_const;  
	wire [0:0]  userinput_load; 
	wire [0:0]  access_grant;

	wire [0:0] game_eog_wire; 
	wire [0:0] scoreboard_eof_wire; 
	wire [31:0] score_board_scores;

	wire [31:0] game_score;
	wire [63:0] game_stream_wire; 

	/*

	buttons : shaped and decoded by the process control
	switches: controled by the process control to allow I/O 

	*/ 
	ButtonShaper b1(clk, PushButtons[0], push_buttons_shaped[0]), 
				 b2(clk, PushButtons[1], push_buttons_shaped[1]),
				 b3(clk, PushButtons[2], push_buttons_shaped[2]);

	
	ButtonDecoder button_decoder(
		.Select(button_select), 
		.ButtonVector(push_buttons_shaped), 
		.ButtonVector1(button_process_control),
		.ButtonVector2(button_access_control), 
		.ButtonVector3(button_game), 
		.ButtonVector4(button_scoreboard)); 
	
	SwitchesControl sw(switches_select,ToggleSwitch,Switches); 

	/*

	process control : main control for the game

	*/  
	wire [0:0] access_control_rst_wire; 
	ProcessControl process_control(
		.clk(clk),
		.rst(rst),  
		.switches(Switches),
		.buttons(button_process_control), 
		.access_control_fb(access_grant), 
		.game_fb(/*  */), 
		.scoreboard_fb(scoreboard_eof_wire), 
		.buttons_select(button_select),
		.switches_select(switches_select), 
		.lcd_control(LCD_select),
		.led_control(LED),
		.game_score_select(score_select),
		.access_control_reset(access_control_rst_wire));

	/*

	access control : password and login 

	*/
	AccessControl access_control(
		.clk(clk),
		.rst(access_control_rst_wire), 
		._Data_In({2'b00,Switches[15:0]}), 
		._Data_In_Load(button_access_control[0]),
		._Access_grant(access_grant),
		.user_ID(userid_const)); 
		 
	/*

	game modules : "tetris"

	*/


	//timer top 

	 
	Game game(
		.clk(clk),
		.rst(rst), 
		.buttons(button_game), 
		.userid(userid_const),
		.gamestate(score_select), 
		.game_eog(game_eog_wire),
		.game_display(game_stream_wire),
		.game_data(game_score));


	/*
	
	score board: 

	*/
	ScoreBoardMain score_board(
		.clk(clk),
		.rst(rst),
		.buttons(button_scoreboard),
		.user_id(userid_const), // needs to come 
		.score(game_score),
		.game_state(score_select),
		.scoreboard_eof(scoreboard_eof_wire),
		.display_wire(score_board_scores)); 

 	/* 
 
 	display:
 		LCD
 		8x8 MATRIX
 		7 segment display
 
 	*/
 	FPGA_2_LCD lcd_display(
 		.CLK(clk),
 		.RST(rst),
 		.LCD_CHAR_ARRAY(LCD_select),
 		.LCD_RS(lcd_RS),
 		.LCD_RW(lcd_RW),
 		.LCD_E(lcd_E),
 	    .LCD_DB(lcd_DB), 
 	    .LCD_ON(lcd_ON));
 

 	LEDMatrixControllerTop matrix(
 		.clk(clk),
 		.rst(rst), 
 		.matrixIn(),  //input stream from game
 		.rowOut(matrix_row),
        .colOut(matrix_col)); 

	wire [31:0] display_wire;
	DisplayScoreMux mux(
		score_select, 
		game_score, 
		score_board_scores, 
		display_wire); 

	Display7Seg seven_seg(
		.userID_score(display_wire),
		.display0(display_0),
		.display1(display_1),
		.display2(display_2),
		.display3(display_3),
		.display4(display_4),
		.display5(display_5),
		.display6(display_6),
		.display7(display_7));
		
endmodule 
