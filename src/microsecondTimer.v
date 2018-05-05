/*
This is a microsecondTimer. With a 50Mhz
clk, the period is 20ns. 50 cycles results
in a microsecond.
microsecondTimer works
*/

module microsecondTimer(clk, rst, timeout);

	input clk, rst;
	output timeout;
	reg pulse;

	reg[5:0] LFSR;
	wire feedback = LFSR[5];


	always @ (posedge clk)
		begin
			if(rst == 0)
				begin
					LFSR <= 6'b111111;
					pulse <= 0;
				end
			else 
				begin
					if(LFSR == 6'b011001)
						begin
							LFSR <= 6'b111111;
							pulse <= 1;
						end
					else 
						begin
							LFSR[0] <= feedback;
							LFSR[1] <= LFSR[0] ^ feedback;
							LFSR[2] <= LFSR[1];
							LFSR[3] <= LFSR[2];
							LFSR[4] <= LFSR[3];
							LFSR[5] <= LFSR[4];
							pulse <= 0;
						end
				end
		end
	assign timeout = pulse;
endmodule
