module control(clk, rst, enable, newBlockLoc, stopBtn, lineNum, stackLoc);
	input clk, rst, enable, stopBtn;
	input [7:0] newBlockLoc;
	output reg [2:0] lineNum;
	output reg [7:0] stackLoc;
	
	reg State;
	parameter INIT = 0, IDLE = 1;
	
	
	
	always @(posedge clk) begin
		if(rst == 0) begin
			lineNum <= 0;
			stackLoc <= 0;
			State <= INIT;
		end
		else begin
			case (State)
				INIT: begin
					if(enable == 1) begin
						if(lineNum == 0) begin
							stackLoc <= newBlockLoc; 
						end
						if(stopBtn == 1) begin
							lineNum <= lineNum + 1;
						end	
					end
					if(lineNum > 6) begin
						State <= IDLE;
					end
				end
				IDLE: begin
					lineNum <= 0;
				end
				default: begin
					State <= INIT;
				end			
			endcase
		end
	end
endmodule

	
	