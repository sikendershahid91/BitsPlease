// Compares the known location of the stack to the new block in the current line.

module comparator(clk, lineNum, newBlockLoc, stacked);
	input clk;
	input [2:0] lineNum;
	input [7:0] newBlockLoc;
	reg [7:0] stackLoc;
	output reg stacked;
		
	always @(posedge clk)begin
		if (lineNum == 0) begin 
			stackLoc <= newBlockLoc;
		end
		else begin
			if(stackLoc == newBlockLoc) begin
				stacked <= 1; 
			end
			else begin 
				stacked <= 0;
			end
		end
	end
endmodule
