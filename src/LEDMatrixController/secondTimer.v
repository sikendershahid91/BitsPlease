/*
second timer based on hundredMillisecondTimer
*/

module secondTimer(pulseIn, clk, rst, pulseOut);

	input pulseIn, clk, rst;
	output wire pulseOut;
	reg pulse;

	reg [3:0] LFSR;
  	wire feedback = LFSR[3];


	always @ (posedge clk)
		begin
			if(rst == 0)
				begin
					LFSR <= 4'b1111;
					pulse <= 0;
				end
			else 
				begin
					if(pulseIn == 1)
						begin
							if(LFSR == 4'b1100)
								begin
									LFSR <= 4'b1111;
									pulse <= 1;
								end
							else 
								begin
									LFSR[0] <= feedback;
								    LFSR[1] <= LFSR[0] ^ feedback;
								    LFSR[2] <= LFSR[1];
								    LFSR[3] <= LFSR[2];
									pulse <= 0;
								end
						end
					else 
						begin
							pulse <= 0;
						end
				end
		end
	assign pulseOut = pulse;
endmodule
