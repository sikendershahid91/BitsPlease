//sikender 


module ScoreBoard(
	input [0:0] clk, 
	input [0:0] rst, 
	input [15:0] userid, 
	input [1:0] game_state, 
	input [15:0] score_data,
	input [15:0] ram_data,
	output reg [31:0] scoreboard_output, 
	output reg [0:0] scoreboard_parity,
	output reg [0:0] wren, 
	output reg [15:0] address 
	); 

	//rember two cycle delay on the ram access 
	reg [1:0] game_state_reg; 
	reg [15:0] data;

	parameter INIT=1, 
			  UPDATE=2, // access ram update players score 
			  SCOREBARD=3, /// acccess ram report scores 
			  DELAY  = 4, 
			  DELAY1 = 5; 


	reg [0:0] STATE; 
	always@(posedge clk) begin
		if(!rst) begin
			STATE <= INIT;
		end else begin
			case(STATE)
				INIT: begin
					scoreboard_output <= 0; 
					wren <= 0;  
					address <= 0; 
					data <= 0;
					game_state_reg <= game_state;
					if (game_state_reg === 2'b01) begin
						score
						wren <= 0; 
						address <= 0; 
						STATE <= SCOREBARD;
					end
					else if (game_state_reg === 2'b10) begin
						data <= score_data;
						address <= userid;  
						wren <=1; 
						STATE <= DELAY; 
					end
					else begin
						STATE <= INIT;
					end
				end
				UPDATE: begin
					address <=0; 
					data <= 0; 
					wren <= 0; 
					game_state_reg <= 0; 
					STATE <= INIT; 
				end
				SCOREBARD: begin // access score board and output result
					if(address !== 16'hFFFF) begin
						scoreboard_output <= {address,ram_data};
						scoreboard_parity <= ~scoreboard_parity; 
						address <= address + 1'b1;
						STATE <= DELAY;  
					end else begin
						scoreboard_output <= {16'hFFFF,16'hFFFF};
						STATE <= INIT; 
					end
				end
				DELAY: begin
					STATE <= DELAY1; 
				end
				DELAY1: begin
					if (game_state === 2'b10) begin
						STATE <= SCOREBARD; // sends all scores to scoreboarddisplay module
					end
					else if (game_state === 2'b01) begin
						STATE <= UPDATE; // keeps updating score until game ends
					end
					else begin
						STATE <= INIT;
					end
				end
				default:begin
					STATE <= INIT;
				end
			endcase
		end
	end
endmodule 