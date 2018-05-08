module control(clk, rst, update, enable, lineNum);
	input clk, rst, update;
	input [7:0] newBlockLoc;
	output reg enable;
	output reg [2:0] lineNum;
	
	reg State;
	parameter INIT = 0, IDLE = 1;
		
	always @(posedge clk) begin
		if(rst == 0) begin
			lineNum <= 0;
			State <= INIT;
		end
		else begin
			case (State)
				INIT: begin
					enable = 1;
					if(update == 1) begin
							lineNum <= lineNum + 1;
						end	
					end
					if(lineNum > 6) begin
						State <= IDLE;
					end
				end
				IDLE: begin
					lineNum <= 0;
					enable = 0;
				end
				default: begin
					State <= INIT;
				end			
			endcase
		end
	end
endmodule

	
	