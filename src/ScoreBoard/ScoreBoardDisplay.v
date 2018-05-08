// get data and sort 

// also outputs to the mux 
module ScoreBoardDisplay(
	input [0:0] clk, 
	input [0:0] rst, 
	input [31:0] data,
	input [2:0] buttons, 
	input [0:0] parity_toggle,
	output reg [0:0] scoreboard_eof,
	output reg [31:0] userid_score_output); 
	

	parameter INIT = 0, 
			  STORE = 1,
			  DISPLAY = 2; 
	reg [2:0] State;
	reg [2:0] count;  

	reg [31:0] scoreboard[2:0]; 

	// take in all the data 
	// output three valued bit 
	always @ (parity_toggle) begin
		if(data[15:0] > scoreboard[0][15:0]) begin
			scoreboard[2] = scoreboard[1]; 
			scoreboard[1] = scoreboard[0];
			scoreboard[0] = data; 
		end else if(data[15:0] > scoreboard[1][15:0]) begin
			scoreboard[2] = scoreboard[1]; 
			scoreboard[1] = data; 
		end else if(data[15:0] > scoreboard[2][15:0]) begin
			scoreboard[2] = data; 
		end
		else begin
			// do nothing with it since its small 
		end
	end  

	always @ (posedge clk) begin
		if(!rst) begin
			State <= INIT; 
		end	else begin
			case(State)
				INIT: begin
					count <= 0; 
					scoreboard_eof <= 0;
					scoreboard[0] <= 31'd0; 
					scoreboard[1] <= 31'd0;
					scoreboard[2] <= 31'd0;
					State <= STORE;  
				end
				STORE: begin
					if (data[15] !== 16'hFFFF) begin
						State <= STORE;
					end 
					else begin
						State <= DISPLAY; 	
					end
				end
				DISPLAY: begin
					if(buttons[0] == 1) begin
						count <=count +1;
					end else if(count !== 2'b11) begin
						scoreboard_eof <= 0; 
						userid_score_output <= scoreboard[count];
						State <= DISPLAY; 
					end else begin
						scoreboard_eof <= 1; 
						userid_score_output <= 0;
						State <= INIT;
					end
				end
				default: begin
					State <= INIT; 
				end
			endcase
		end
	end
endmodule 