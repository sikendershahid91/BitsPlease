//sikender

module ProcessControl(
	input [0:0] clk, 
	input [0:0] rst, 

	//hardware signals 
	input  [17:0] switches, // we are doing this for security  
	input  [2:0]  buttons,
	output [2:0]  buttons_select,
	
	//feedback signals 
	input [0:0] access_control_fb, 
	input [0:0] game_fb, 
	input [0:0] scoreboard_fb, 
	
	//password
	output reg [15:0] userinput, 
	output reg [0:0]  load, 
//	output reg [0:0]  password_change,

	//lcd & LEDs
	output reg [2:0] lcd_control,
	output reg [3:0] led_control,  

	//score & game
	output reg [15:0] userid,
	output reg [1:0]  game_score_select
	); 

	parameter 
			  INIT=0, 
			  ACCESSCONTROL=1,
			  TRANSITION=2,
	 		  GAME=3,
	 		  SCOREBOARD=4;

	reg [2:0] STATE;

	always @(posedge clk) begin
		if(!rst) begin
			STATE <= INIT; 
		end
		else begin
			case(STATE)
				INIT: begin
					buttons_select <= 1; 
					userinput <= 0; 
					load <= 0;  
					lcd_control <= 0; 
					led_control <= 0; 
					userid <= 0; 
					game_score_select <= 0; 
					if(buttons[0] == 1) begin
						STATE <= ACCESSCONTROL; 
					end
					else begin
						STATE <= INIT; 
					end
				end
				ACCESSCONTROL: begin // need to add delays
					buttons_select <= 1; 
					userinput <= switches[15:0]; 
					userid <= switches[15:0]; 
					load <= buttons[0]; 
					lcd_control <= 1; 
					if(access_control_fb == 1) begin
						STATE <= GAME; 
						led_control <= 2; // green
					end else begin
						STATE <= ACCESSCONTROL;
						led_control <= 1; 
						lcd_control <= 2;// red
					end
				end
				TRANSITION: begin
					buttons_select <= 1; 
					lcd_control <=3; 
					if(buttons[2] == 1) begin
						STATE <= GAME; 
					end
					else if(buttons[1] == 1) begin
						STATE <= SCOREBOARD; 
					end
					else if(buttons[0] == 1) begin
						STATE <= INIT; 
					end
					else begin
						STATE <= TRANSITION; 
					end
				end
				GAME: begin
					buttons_select <= 2; 
					game_score_select <= 1; 
					if(game_fb == 1) begin
						STATE <= TRANSITION; 
					end
					else begin
						STATE <= GAME; 
					end
				end
				SCOREBOARD: begin
					buttons_select <= 3; 
					game_score_select <= 2; 
					if(scoreboard_fb == 1) begin
						STATE <= TRANSITION; 
					end else begin
						STATE <= SCOREBOARD; 
					end
				end
				default: begin
					STATE <= INIT;
				end
			endcase
		end
	end
endmodule 